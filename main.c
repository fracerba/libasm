#include "libasm.h"

int main(int argc, char **argv) {
    char src[] = "Hello, world!\n";
    char dest[20];
    char dest2[20];
    char *dup;
    char *dup2;
    ssize_t w_ret, r_ret;
    char buf[50];
    int cmp;

    printf("===== MANDATORY TESTS =====\n");
    // ft_strlen
    printf("-------- ft_strlen --------\n");
    printf("ft_strlen: %lu\n", ft_strlen(src));
    printf("strlen: %lu\n", strlen(src));
    printf("\n");

    // ft_strcpy
    printf("-------- ft_strcpy --------\n");
    ft_strcpy(dest, src);
    strcpy(dest2, src);
    printf("ft_strcpy: %s", dest);
    printf("strcpy: %s", dest2);
    printf("\n");

    // ft_strcmp
    printf("-------- ft_strcmp --------\n");
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
    printf("-------- ft_strdup --------\n");
    dup = ft_strdup(src);
    printf("ft_strdup: %s", dup);
    free(dup);
    dup2 = strdup(src);
    printf("strdup: %s", dup2);
    free(dup2);
    printf("\n");

    // ft_write
    printf("-------- ft_write ---------\n");
    write(1, "ft_write: ", 11);
    w_ret = ft_write(1, src, ft_strlen(src));
    printf("Return value: %ld\n", w_ret);
    write(1, "write: ", 7);
    w_ret = write(1, src, strlen(src));
    printf("Return value: %ld\n", w_ret);
    printf("\n");

    // ft_read
    printf("--------- ft_read ---------\n");
    write(1, "Type something\nft_read: ", 24);
    r_ret = ft_read(0, buf, sizeof(buf)-1);
    if (r_ret >= 0) {
        buf[r_ret] = '\0';
        printf("Buffer: %sReturn value: %ld\n", buf, r_ret);
    } else {
        perror("ft_read");
    }
    write(1, "Type something\nread: ", 21);
    r_ret = read(0, buf, sizeof(buf)-1);
    if (r_ret >= 0) {
        buf[r_ret] = '\0';
        printf("Buffer: %sReturn value: %ld\n", buf, r_ret);
    } else {
        perror("read");
    }

    if (argc < 2 || strcmp(argv[1], "all") == 0)
        return 0;

    printf("\n===== BONUS TESTS =====\n");
    
    t_list *list = NULL;
    t_list *tmp;
    int size;

    printf("------ ft_atoi_base -------\n");
    printf("Base 10: %d\n", ft_atoi_base("42", "0123456789"));
    printf("Base 2: %d\n", ft_atoi_base("101010", "01"));
    printf("Base 4: %d\n", ft_atoi_base("222", "0123"));
    printf("Base 8: %d\n", ft_atoi_base("52", "01234567"));
    printf("Base 16: %d\n", ft_atoi_base("2A", "0123456789ABCDEF"));
    printf("Invalid base (repeated chars): %d\n", ft_atoi_base("42", "0123401234"));
    printf("Invalid base (only one char): %d\n", ft_atoi_base("42", "0"));
    printf("\n");

    printf("--- ft_list_push_front ----\n");
    ft_list_push_front(&list, "First");
    ft_list_push_front(&list, "Second");
    ft_list_push_front(&list, "Third");
    
    tmp = list;
    while (tmp) {
        printf("Node data: %s\n", (char *)tmp->data);
        tmp = tmp->next;
    }
    printf("\n");
    
    printf("------ ft_list_size -------\n");
    printf("List size: %d\n", ft_list_size(list));

    return 0;
}
