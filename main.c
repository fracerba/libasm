#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include "libasm.h"

int main(void) {
    char src[] = "Hello, world!";
    char dest[20];
    char dest2[20];
    char *dup;
    char *dup2;
    ssize_t w_ret, r_ret;
    char buf[20];
    int cmp;

    // ft_strlen
    printf("ft_strlen: %d\n", ft_strlen(src));
    printf("strlen: %d\n", strlen(src));
    printf("\n");

    // ft_strcpy
    ft_strcpy(dest, src);
    strcpy(dest2, src);
    printf("ft_strcpy: %s\n", dest);
    printf("strcpy: %s\n", dest2);
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
    printf("ft_strdup: %s\n", dup);
    free(dup);
    dup2 = strdup(src);
    printf("strdup: %s\n", dup2);
    free(dup2);
    printf("\n");

    // ft_write
    w_ret = ft_write(1, src, ft_strlen(src));
    printf("ft_write returned: %d\n", w_ret);
    w_ret = write(1, src, strlen(src));
    printf("write returned: %d\n", w_ret);
    printf("\n");

    // ft_read
    printf("Type something: ");
    r_ret = ft_read(0, buf, sizeof(buf)-1);
    if (r_ret >= 0) {
        buf[r_ret] = '\0';
        printf("ft_read: %s\n", buf);
    } else {
        perror("ft_read");
    }
    printf("Type something: ");
    r_ret = read(0, buf, sizeof(buf)-1);
    if (r_ret >= 0) {
        buf[r_ret] = '\0';
        printf("read: %s\n", buf);
    } else {
        perror("read");
    }
    printf("\n");

    return 0;
}
