#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "fsfixer.h"

fsystem_t fs;

//Declaring helper functions
static int test_inode(uint32_t ino);
static int test_direct(ospfs_inode_t *inode);
static int test_indirect(ospfs_inode_t *inode);
static int test_indirect2(ospfs_inode_t *inode);
static int reduce_inode(ospfs_inode_t *inode, int n);
static uint32_t fs_inode_blockno(ospfs_inode_t *oi, uint32_t offset);
static void *fs_inode_data(ospfs_inode_t *oi, uint32_t offset);
static void bitmap_set(uint32_t blkno, int free);
static int bitmap_get(uint32_t blkno);

void *fs_block(uint32_t blkno)
{
    return fs.buffer + (blkno * OSPFS_BLKSIZE);
}

void *fs_block_data(uint32_t blkno, uint32_t offset)
{
    return fs.buffer + (blkno * OSPFS_BLKSIZE) + offset;
}


static int test_superblock()
{
    fprintf(stderr, "\nTesting Superblock\n");
    int retvalue = PASS;

    //Test if there is sufficient size for superblock
    if (fs.buffer_size < 2 * OSPFS_BLKSIZE)
    {
        unfixable("Insufficient size for superblock");
        return UNFIXABLE;
    }

    ospfs_super_t *img_super = (ospfs_super_t*)fs_block(1);

    //Test image's magic number
    fs.super.os_magic = OSPFS_MAGIC;
    if (img_super->os_magic != OSPFS_MAGIC)
    {
        fixed("Magic number was corrected");
        retvalue = FIXED;
    }

    //Test image's number of blocks
    fs.super.os_nblocks = fs.buffer_size / OSPFS_BLKSIZE;
    if (img_super->os_nblocks != fs.super.os_nblocks)
    {
        fixed("Number of blocks was corrected");
        retvalue = FIXED;
    }

    //Test first inode block
    uint32_t bytes_in_bitmap = fs.super.os_nblocks / 8;
    if (bytes_in_bitmap % OSPFS_BLKSIZE)
    {
        bytes_in_bitmap -= (bytes_in_bitmap % OSPFS_BLKSIZE);
        bytes_in_bitmap += OSPFS_BLKSIZE;
    }
    uint32_t no_bitmap_blks = bytes_in_bitmap / OSPFS_BLKSIZE;
    fs.no_bitmap_blks = no_bitmap_blks;
    fs.super.os_firstinob = OSPFS_FREEMAP_BLK + no_bitmap_blks;
    if (img_super->os_firstinob != fs.super.os_firstinob)
    {
        fixed("First inode block was corrected");
        retvalue = FIXED;
    }

    //Test the number of inodes
    uint32_t max_inodes = OSPFS_BLKINODES*(fs.super.os_nblocks - (fs.super.os_firstinob + 1));
    fs.super.os_ninodes = img_super->os_ninodes;
    if (img_super->os_ninodes > max_inodes)
    {
        unfixable("Insufficient size for amount of inodes");
        return UNFIXABLE;
    }

    return retvalue;
}

static int test_inodes()
{
    fprintf(stderr, "\nTesting Inodes\n");
    int retvalue = PASS;
    int r;

    fs.inodes = calloc(fs.super.os_ninodes, sizeof(ospfs_inode_t));

    //Test each inode one by one
    uint32_t i = 1;
    while (i < fs.super.os_ninodes)
    {
        r = test_inode(i);
        if (r == FIXED)
            retvalue = FIXED;
        if (r == UNFIXABLE)
            return UNFIXABLE;
        i++;
    }

    return retvalue;
}

static int test_references()
{
    printf("\nTesting Block References\n");
    int retvalue = PASS;
    int r;

    //Allocate and initialize the free block bitmap
    int blocks_in_bitmap = fs.super.os_nblocks / OSPFS_BLKBITSIZE;
    if (fs.super.os_nblocks % OSPFS_BLKBITSIZE)
        blocks_in_bitmap++;
    fs.freeblk_bitmap = malloc(blocks_in_bitmap * OSPFS_BLKSIZE);

    int blocks_for_inodes = fs.super.os_ninodes / OSPFS_BLKINODES;
    if (fs.super.os_ninodes % OSPFS_BLKINODES)
        blocks_for_inodes++;
    int lastinob = fs.super.os_firstinob + blocks_for_inodes;
    int i = 0;
    while (i < lastinob)
    {
        bitmap_set(i, 0);
        i++;
    }
    while (i < fs.super.os_nblocks)
    {
        bitmap_set(i, 1);
        i++;
    }

    // Checks the referenced blocks of all inodes.
    uint32_t j = 1;
    while(j < fs.super.os_ninodes)
    {
        ospfs_inode_t *inode = &fs.inodes[j];
        //Only test used inodes
        if (inode->oi_nlink)
        {
            //Only test regular files and directories
            if (inode->oi_ftype == OSPFS_FTYPE_REG || inode->oi_ftype == OSPFS_FTYPE_DIR)
            {
                fprintf(stderr, "Inode %d:\n", j);
                //Test direct references
                r = test_direct(inode);
                if (r == FIXED)
                    retvalue = FIXED;
                if (r == UNFIXABLE)
                    return UNFIXABLE;
                //Test indirect references
                r = test_indirect(inode);
                if (r == FIXED)
                    retvalue = FIXED;
                if (r == UNFIXABLE)
                    return UNFIXABLE;
                //Test indirect2 references
                r = test_indirect2(inode);
                if (r == FIXED)
                    retvalue = FIXED;
                if (r == UNFIXABLE)
                    return UNFIXABLE;
            }
        }
        j++;
    }

    return retvalue;
}

static int test_directories()
{
    printf("\nTesting Directories\n");
    int result = PASS;
    int i = 0;
    for (i = 0; i < fs.super.os_ninodes; i++)
        fs.inodes[i].oi_nlink = 0;
    i = 0;
    while (i < fs.super.os_ninodes)
    {
        ospfs_inode_t *inode = &fs.inodes[i];
        if (inode->oi_ftype == OSPFS_FTYPE_DIR)
        {
            int offset = 0;
            while (offset < inode->oi_size)
            {
                ospfs_direntry_t *direntry = fs_inode_data(inode, offset);
                if (direntry->od_ino)
                {
                    if (strchr(direntry->od_name, '\0') == NULL) //Test if entry has a valid name
                    {
                        fixed("Removed directory entry with invalid name");
                        result = FIXED;
                    }
                    else if (fs.super.os_ninodes <= direntry->od_ino) //Test if entry has a valid inode
                    {
                        fixed("Removed directory entry with invalid inode");
                        result = FIXED;
                    }
                    else //Increase oi_nlink for valid inodes
                    {
                        fprintf(stderr, "%s refers to inode %d\n", direntry->od_name, direntry->od_ino);
                        fs.inodes[direntry->od_ino].oi_nlink++;
                    }
                }
                offset += OSPFS_DIRENTRY_SIZE;
            }
        }
        i++;
    }

    return result;
}

static int test_bitmap()
{
    fprintf(stderr, "\nTesting Free Block Bitmap\n");

    // Compares our bitmap with the image's bitmap.
    if (memcmp(fs.freeblk_bitmap, fs_block(2), fs.no_bitmap_blks * OSPFS_BLKSIZE) == 0)
        return PASS;
    fixed("Bitmap corrected");
    return FIXED;
}


int test_fs()
{
    int r;
    int retvalue = PASS;

    //Testing superblock
    r = test_superblock();
    if (r == FIXED)
        retvalue = FIXED;
    if (r == UNFIXABLE)
        return UNFIXABLE;
    //Testing inodes
    r = test_inodes();
    if (r == FIXED)
        retvalue = FIXED;
    if (r == UNFIXABLE)
        return UNFIXABLE;
    //Testing references
    r = test_references();
    if (r == FIXED)
        retvalue = FIXED;
    if (r == UNFIXABLE)
        return UNFIXABLE;
    //Testing directories
    r = test_directories();
    if (r == FIXED)
        retvalue = FIXED;
    if (r == UNFIXABLE)
        return UNFIXABLE;
    //Testing bitmap
    r = test_bitmap();
    if (r == FIXED)
        retvalue = FIXED;
    if (r == UNFIXABLE)
        return UNFIXABLE;

    return retvalue;
}

//Tests a single inode
int test_inode(uint32_t ino)
{
    int retvalue = PASS;

    ospfs_inode_t *inode = fs_block_data(fs.super.os_firstinob, ino * OSPFS_INODESIZE);
    if (inode->oi_nlink == 0)
        return PASS;

    ospfs_inode_t *temp = &fs.inodes[ino];

    if (inode->oi_ftype == OSPFS_FTYPE_REG || inode->oi_ftype == OSPFS_FTYPE_DIR)
    {
        //Test size
        if (inode->oi_size > OSPFS_MAXFILESIZE)
        {
            temp->oi_size = OSPFS_MAXFILESIZE;
            fixed("Corrected file size too big");
            retvalue = FIXED;
        }
        else
            temp->oi_size = inode->oi_size;

        temp->oi_mode = inode->oi_mode;

        // Set direct and indirect block pointers
        if (((OSPFS_NDIRECT + OSPFS_NINDIRECT) * OSPFS_BLKSIZE) < temp->oi_size)
            temp->oi_indirect2 = inode->oi_indirect;
        if ((OSPFS_NDIRECT * OSPFS_BLKSIZE) < temp->oi_size)
            temp->oi_indirect = inode->oi_indirect;
        int i = 0;
        while (i < OSPFS_NDIRECT)
        {
            temp->oi_direct[i] = inode->oi_direct[i];
            i++;
        }
    }
    else if (inode->oi_ftype == OSPFS_FTYPE_SYMLINK)
    {
        ospfs_symlink_inode_t *symlink_inode = (ospfs_symlink_inode_t *)inode;
        ospfs_symlink_inode_t *temp_sym = (ospfs_symlink_inode_t *)temp;

        //Copy size and symlink name
        symlink_inode->oi_size = 0;
        int i = 0;
        while (i < OSPFS_MAXSYMLINKLEN)
        {
            temp_sym->oi_symlink[i] = symlink_inode->oi_symlink[i];
            if (symlink_inode->oi_symlink[i] == '\0')
                break;
            symlink_inode->oi_size++;
            i++;
        }
        if (temp_sym->oi_symlink[i] != '\0')
        {
            temp_sym->oi_symlink[i] = '\0';
            fixed("Symlink too long: reduced to maximum length");
            retvalue = FIXED;
        }
    }
    else
    {
        //Invalid inode type
        fixed("Removed inode with invalid type");
        return FIXED;
    }

    temp->oi_nlink = inode->oi_nlink;
    temp->oi_ftype = inode->oi_ftype;
    fprintf(stderr, "Testing inode complete: Results:\n");
    fprintf(stderr, "oi_size = %d\n", temp->oi_size);
    fprintf(stderr, "oi_ftype = %d\n", temp->oi_ftype);
    fprintf(stderr, "oi_nlink = %d\n", temp->oi_nlink);
    if (temp->oi_ftype == OSPFS_FTYPE_REG || temp->oi_ftype == OSPFS_FTYPE_DIR)
    {
        printf("oi_mode = %d\n", temp->oi_mode);
        printf("oi_direct = ");
        int i = 0;
        while (i < OSPFS_NDIRECT)
        {
            printf("(%d) ", temp->oi_direct[i]);
            i++;
        }
        printf("\n");
        printf("oi_indirect = %d\n", temp->oi_indirect);
        printf("oi_indirect2 = %d\n", temp->oi_indirect2);

    }

    return retvalue;
}

int test_direct(ospfs_inode_t *inode)
{
    int i;
    while (i < OSPFS_NDIRECT)
    {
        uint32_t block = inode->oi_direct[i];
        //Reduce inode if at the end of file or more than one reference
        if (block == 0)
            return reduce_inode(inode, i);
        if (!bitmap_get(block))
        {
            reduce_inode(inode, i);
            fprintf(stderr, "Error fixed: More than one reference to direct block %d\n", block);
            return FIXED;
        }
        bitmap_set(block, 0);
        i++;
    }

    return PASS;
}

int test_indirect(ospfs_inode_t *inode)
{
    //Reduce inode if at the end of file or more than one reference
    if (!inode->oi_indirect)
        return reduce_inode(inode, OSPFS_NDIRECT);
    if (!bitmap_get(inode->oi_indirect))
    {
        reduce_inode(inode, OSPFS_NDIRECT);
        fixed("More than one reference to indirect block");
        return FIXED;
    }

    //Test every indirect reference block
    uint32_t *indirect_block = fs_block(inode->oi_indirect);

    int i;
    while (i < OSPFS_NINDIRECT)
    {
        //Same actions as before
        if (!indirect_block[i])
            return reduce_inode(inode, OSPFS_NDIRECT + i);
        if (!bitmap_get(indirect_block[i]))
        {
            reduce_inode(inode, OSPFS_NDIRECT + i);
            fixed("More than one reference to indirect block");
            return FIXED;
        }
        bitmap_set(indirect_block[i], 0);
        i++;
    }

    return PASS;
}

int test_indirect2(ospfs_inode_t *inode)
{
    //Check indirect2 block
    if (!inode->oi_indirect2)
        return reduce_inode(inode, OSPFS_NDIRECT + OSPFS_NINDIRECT);
    if (!bitmap_get(inode->oi_indirect2))
    {
        reduce_inode(inode, OSPFS_NDIRECT + OSPFS_NINDIRECT);
        fixed("More than one reference to indirect2 block");
        return FIXED;
    }
    //Check indirect blocks inside indirect2 block
    uint32_t *indirect_block2 = fs_block(inode->oi_indirect2);
    int i = 0;
    int block = OSPFS_NDIRECT + OSPFS_NINDIRECT;
    while (i < OSPFS_NINDIRECT)
    {
        if (!indirect_block2[i])
            return reduce_inode(inode, block);
        if (!bitmap_get(indirect_block2[i]))
        {
            reduce_inode(inode, block);
            fprintf(stderr, "More than one reference to oi_indirect2[%d]\n", i);
            return FIXED;
        }

        //Check data blocks
        uint32_t *indirect_block = fs_block(indirect_block2[i]);
        int j = 0;
        while (j < OSPFS_NINDIRECT)
        {
            if (!indirect_block[j])
                return reduce_inode(inode, block);
            if (!bitmap_get(indirect_block[j]))
            {
                reduce_inode(inode, block);
                fprintf(stderr, "More than one reference to oi_indirect2[%d]->[%d]\n", i, j);
                return FIXED;
            }
            block++;
            j++;
        }
        i++;
    }

    return PASS;
}

int reduce_inode(ospfs_inode_t *inode, int n)
{
    fprintf(stderr, "Reducing inode to %d blocks\n", n);
    uint32_t size_max = n * OSPFS_BLKSIZE;

    //Setting all other blocks to 0 according to n
    if (n >= OSPFS_NDIRECT + OSPFS_NINDIRECT)
    {
        uint32_t *indirect_block2 = fs_block(inode->oi_indirect2);
        uint32_t direct_block = n % OSPFS_NINDIRECT;
        uint32_t indirect_block = n / OSPFS_NINDIRECT;
        uint32_t *indirect_block_ptr = fs_block(indirect_block2[direct_block]);
        if (!direct_block)
            indirect_block2[indirect_block] = 0;
        int i = indirect_block + 1;
        while (i < OSPFS_NINDIRECT)
        {
            indirect_block2[i] = 0;
            i++;
        }
        i = direct_block;
        while (i < OSPFS_NINDIRECT)
        {
            indirect_block_ptr[i] = 0;
            i++;
        }
    }
    else if (n > OSPFS_NDIRECT)
    {
        uint32_t *indirect_blocks = fs_block(inode->oi_indirect);
        int i = n - OSPFS_NDIRECT;
        while (i < OSPFS_NDIRECT + OSPFS_NINDIRECT)
        {
            indirect_blocks[i] = 0;
            i++;
        }
        inode->oi_indirect2 = 0;
    }
    else
    {
        int i = n;
        while (i < OSPFS_NDIRECT)
        {
            inode->oi_direct[i] = 0;
            i++;
        }
        inode->oi_indirect = 0;
        inode->oi_indirect2 = 0;
    }

    // Updates the filesize if necessary.
    if (size_max < inode->oi_size)
    {
        inode->oi_size = size_max;
        fixed("Updated inode size");
        return FIXED;
    }

    return PASS;
}


//Bringing in some (modified) functions from ospfsmod.c from Lab 3
uint32_t fs_inode_blockno(ospfs_inode_t *oi, uint32_t offset)
{
    uint32_t blockno = offset / OSPFS_BLKSIZE;
    if (offset >= oi->oi_size || oi->oi_ftype == OSPFS_FTYPE_SYMLINK)
        return 0;
    else if (blockno >= OSPFS_NDIRECT + OSPFS_NINDIRECT) {
        uint32_t blockoff = blockno - (OSPFS_NDIRECT + OSPFS_NINDIRECT);
        uint32_t *indirect2_block = fs_block(oi->oi_indirect2);
        uint32_t *indirect_block = fs_block(indirect2_block[blockoff / OSPFS_NINDIRECT]);
        return indirect_block[blockoff % OSPFS_NINDIRECT];
    }
    else if (blockno >= OSPFS_NDIRECT) {
        uint32_t *indirect_block = fs_block(oi->oi_indirect);
        return indirect_block[blockno - OSPFS_NDIRECT];
    }
    else
        return oi->oi_direct[blockno];
}

void *fs_inode_data(ospfs_inode_t *oi, uint32_t offset)
{
    uint32_t blockno = fs_inode_blockno(oi, offset);
    return (uint8_t *)fs_block(blockno) + (offset % OSPFS_BLKSIZE);
}

//Sets the bit corresponding to blkno
static void bitmap_set(uint32_t blkno, int free)
{
    uint8_t *byte = (uint8_t *)fs.freeblk_bitmap + (blkno / 8);
    uint8_t mask = 0x01 << (7 - (blkno % 8));
    if (free)
        *byte = *byte | mask;
    else
        *byte = *byte & (~mask);
}

//Gets the bit corresponding to blkno
static int bitmap_get(uint32_t blkno)
{
    uint8_t *byte = (uint8_t *)fs.freeblk_bitmap + (blkno / 8);
    uint8_t mask = 0x01 << (7 - (blkno % 8));
    if (*byte & mask)
        return 1;
    else
        return 0;
}
