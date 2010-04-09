Erlang Git: an experiment with Erlang binary parsing
====================================================

Example Usage
-------------
Get details of the HEAD^ commit:  
    rr("include/git.hrl").
    #commit{parent = P} = git:object(git:head()).
    git:object(git:sha(P)).

Tree File Format
----------------
    type(*,c) size(*,d)\0mode(6,d)\0 filename\0

File Mode (man 2 stat)
----------------------
The following flags are defined for the st_mode field:

       S_IFMT     0170000   bit mask for the file type bit fields
       S_IFSOCK   0140000   socket
       S_IFLNK    0120000   symbolic link
       S_IFREG    0100000   regular file
       S_IFBLK    0060000   block device
       S_IFDIR    0040000   directory
       S_IFCHR    0020000   character device
       S_IFIFO    0010000   FIFO
       S_ISUID    0004000   set UID bit
       S_ISGID    0002000   set-group-ID bit (see below)
       S_ISVTX    0001000   sticky bit (see below)
       S_IRWXU    00700     mask for file owner permissions
       S_IRUSR    00400     owner has read permission
       S_IWUSR    00200     owner has write permission
       S_IXUSR    00100     owner has execute permission
       S_IRWXG    00070     mask for group permissions
       S_IRGRP    00040     group has read permission
       S_IWGRP    00020     group has write permission
       S_IXGRP    00010     group has execute permission
       S_IRWXO    00007     mask for permissions for others (not in group)
       S_IROTH    00004     others have read permission

       S_IWOTH    00002     others have write permission
       S_IXOTH    00001     others have execute permission
