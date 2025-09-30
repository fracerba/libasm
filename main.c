#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include "libasm.h"

int main(void) {
    char src[] = "Hello, world!\n";
    char dest[20];
    char dest2[20];
    char *dup;
    char *dup2;
    ssize_t w_ret, r_ret;
    char buf[20];
    int cmp;

    // ft_strlen
    printf("ft_strlen: %lu\n", ft_strlen(src));
    printf("strlen: %lu\n", strlen(src));
    printf("\n");

    // ft_strcpy
    ft_strcpy(dest, src);
    strcpy(dest2, src);
    printf("ft_strcpy: %s", dest);
    printf("strcpy: %s", dest2);
    printf("\n");

    // ft_strcmp
    cmp = ft_strcmp(src, dest);
    printf("ft_strcmp: %d\n", cmp);
    cmp = ft_strcmp(src, "Hello");
    printf("ft_strcmp (diff): %d\n", cmp);
    cmp = strcmp(src, dest2);
    printf("strcmp: %d\n", cmp);
    cmp = strcmp(src, "Hello");
    printf("strcmp (diff): %d\n", cmp);
    printf("\n");

    // ft_strdup
    dup = ft_strdup(src);
    printf("ft_strdup: %s", dup);
    free(dup);
    dup2 = strdup(src);
    printf("strdup: %s", dup2);
    free(dup2);
    printf("\n");

    // ft_write
    write(1, "ft_write: ", 11);
    w_ret = ft_write(1, src, ft_strlen(src));
    printf("Return value: %ld\n", w_ret);
    write(1, "write: ", 7);
    w_ret = write(1, src, strlen(src));
    printf("Return value: %ld\n", w_ret);
    printf("\n");

    // ft_read
    write(1, "ft_read: Type something... ", 27);
    r_ret = ft_read(0, buf, sizeof(buf)-1);
    if (r_ret >= 0) {
        buf[r_ret] = '\0';
        printf("ft_read: %s", buf);
    } else {
        perror("ft_read");
    }
    write(1, "read: Type something... ", 25);
    r_ret = read(0, buf, sizeof(buf)-1);
    if (r_ret >= 0) {
        buf[r_ret] = '\0';
        printf("read: %s", buf);
    } else {
        perror("read");
    }
    return 0;
}
