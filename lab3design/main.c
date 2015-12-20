#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fsfixer.h"

// Loads the filesystem
void load_fs(int argc, char **argv)
{
    printf("Loading filesystem\n");
    if (argc == 2)
    {
        FILE *file;
        if (MAXFILENAMELEN < strlen(argv[1]))
        {
            error("Filename too long");
            exit(1);
        }
        if (!(file = fopen(argv[1], "r"))) 
        {
            error("Cannot open filesystem");
            exit(1);
        }

        if (fseek(file, 0L, SEEK_END) == -1
            || (fs.buffer_size = ftell(file)) == -1
            || fseek(file, 0L, SEEK_SET) == -1
            || !(fs.buffer = malloc(fs.buffer_size + 1)))
        {
            error("Error reading file");
            exit(1);
        }
        fread(fs.buffer, 1, fs.buffer_size, file);
        printf("Filesystem Loaded\n");
        fclose(file);
    }
    else
    {
        printf("Invalid argument\n");
        exit(1);
    }
}

// Writes the filesystem
void write_fs()
{
    printf("Writing fixed image: fixed.img\n");

    FILE* file = fopen("fixed_fs.img", "w");
    if (!file)
    {
        error("Cannot write filesystem\n");
        return;
    }

    //Write boot block
    fwrite(fs_block(0), OSPFS_BLKSIZE, 1, file);

    //Write superblock
    size_t fill_size = OSPFS_BLKSIZE - sizeof(ospfs_super_t);
    void *filler = malloc(fill_size);
    memset(filler, 0, fill_size);
    fwrite(&fs.super, sizeof(ospfs_super_t), 1, file);
    fwrite(filler, fill_size, 1, file);

    //Writes free block bitmap
    fwrite(fs.freeblk_bitmap, OSPFS_BLKSIZE, fs.no_bitmap_blks, file);

    //Write inodes
    fwrite(fs.inodes, sizeof(ospfs_inode_t), fs.super.os_ninodes, file);
    size_t size_written = sizeof(ospfs_inode_t) * fs.super.os_ninodes;
    size_t last_inob_size = size_written % OSPFS_BLKSIZE;
    if (last_inob_size)
        fwrite(fs.inodes, 1, OSPFS_BLKSIZE - last_inob_size, file);

    //Write data blocks
    size_t inode_blocks = fs.super.os_ninodes / OSPFS_BLKINODES;
    if (fs.super.os_ninodes % OSPFS_BLKINODES)
        inode_blocks++;
    fwrite(fs_block(fs.super.os_firstinob + inode_blocks), OSPFS_BLKSIZE, fs.super.os_nblocks, file);

    fclose(file);
}

int main(int argc, char **argv)
{
    load_fs(argc, argv);
    switch (test_fs())
    {
    case PASS:
        printf("Filesystem passed with no errors\n");
        break;
    case FIXED:
        printf("Errors with filesystem have been fixed\n");
        write_fs();
        break;
    case UNFIXABLE:
        printf("Filesystem is unfixable\n");
        break;
    default:
        error("Unknown error\n");
        break;
    }
    return 0;
}

void error(const char *msg)
{
    fprintf(stderr, "%s:%d: Error: %s\n", __FILE__, __LINE__, msg);
}

void fixed(const char *msg)
{
    fprintf(stderr, "Error fixed: %s\n", msg);
}

void unfixable(const char *msg)
{
    fprintf(stderr, "Unfixable error: %s\n", msg);
}
