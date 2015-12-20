#ifndef FSFIXER_H
#define FSFIXER_H

#include <stdint.h>
#include <errno.h>
#include "ospfs.h"

#define MAXFILENAMELEN OSPFS_BLKSIZE

//Define data structure to hold information about file system
typedef struct fsystem
{
    // This holds the name of the input file.
    char system_name[MAXFILENAMELEN + 1];

    // This buffer holds the contents of the input file.
    void *buffer;
    uint32_t buffer_size;

    // This holds the correct superblock. It is filled in while checking the
    // superblock
    ospfs_super_t super;

    // This points to an inode buffer. Its size is determined after obtaining
    // os_ninodes from the superblock.
    ospfs_inode_t *inodes;

    // This points to the block bitmap. We set blocks to used upon seeing
    // a reference to that block.
    uint32_t no_bitmap_blks;
    void *freeblk_bitmap;
} fsystem_t;

extern fsystem_t fs;
void *fs_block(uint32_t blkno);
void *fs_block_data(uint32_t blkno, uint32_t offset);
int test_fs();

//Define functions for printing error messages
void error(const char *msg);
void fixed(const char *msg);
void unfixable(const char *msg);

//Define return values
//typedef enum {PASS, FIXED, UNFIXABLE} retvalue;
#define PASS 0
#define FIXED 1
#define UNFIXABLE 2

#endif // FSFIXER_H
