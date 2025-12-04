#include "libasm.h"

void print_list(t_list *list) {
	t_list *tmp = list;
	while (tmp) {
		printf("Node data: %s\n", (char *)tmp->data);
		tmp = tmp->next;
	}
}

void print_write(ssize_t w_ret, char *str, int is_file) {
	if (w_ret < 0)
		perror(str);
	else if (is_file)
		printf("Return value (file): %ld\n", w_ret);
	else
		printf("Return value: %ld\n", w_ret);
}

void print_read(ssize_t r_ret, char *buf, char *str) {
	if (r_ret >= 0) {
		buf[r_ret] = '\0';
		printf("Buffer: %sReturn value: %ld\n", buf, r_ret);
	} else {
		perror(str);
	}
}

int main() {
	char	src[] = "Hello, world!\n";
	char	*file = "test.txt";
	char	dest[20];
	char	dest2[20];
	char	*dup;
	char	*dup2;
	char	*dup3;
	ssize_t	w_ret, r_ret;
	char	buf[50];
	int		cmp, fd;
	t_list	*list = NULL;

	printf("===== MANDATORY TESTS =====\n");

	// ft_strlen
	printf("-------- ft_strlen --------\n");
	printf("ft_strlen: %lu\n", ft_strlen(src));
	printf("strlen: %lu\n", strlen(src));
	printf("\n");

	// ft_strcpy
	printf("-------- ft_strcpy --------\n");
	ft_strcpy(dest, src);
	printf("ft_strcpy: %s", dest);
	strcpy(dest2, src);
	printf("strcpy: %s", dest2);
	printf("\n");

	// ft_strcmp
	printf("-------- ft_strcmp --------\n");
	cmp = ft_strcmp(src, dest);
	printf("ft_strcmp: %d\n", cmp);
	cmp = ft_strcmp(src, "Hello");
	printf("ft_strcmp (diff): %d\n", cmp);
	printf("\n");

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
	fd = open(file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd < 0) {
		perror("open outfile");
		return (1);
	}
	write(1, "ft_write: ", 11);
	w_ret = ft_write(1, src, ft_strlen(src));
	print_write(w_ret, "ft_write" , 0);
	w_ret = ft_write(fd, src, ft_strlen(src));
	print_write(w_ret, "ft_write to file", 1);
	printf("\n");

	write(1, "write: ", 7);
	w_ret = write(1, src, ft_strlen(src));
	print_write(w_ret, "write", 0);
	w_ret = write(fd, src, ft_strlen(src));
	print_write(w_ret, "write to file", 1);
	close(fd);
	printf("\n");

	// ft_read
	printf("--------- ft_read ---------\n");
	fd = open(file, O_RDONLY);
	if (fd < 0)
	{
		perror("open infile");
		return (1);
	}
	printf("Type something\n");
	write(1, "ft_read: ", 9);
	r_ret = ft_read(0, buf, sizeof(buf)-1);
	print_read(r_ret, buf, "ft_read");
	printf("ft_read from file:\n");
	r_ret = ft_read(fd, buf, sizeof(buf)-1);
	print_read(r_ret, buf, "ft_read from file");
	close(fd);
	printf("\n");

	fd = open(file, O_RDONLY);
	if (fd < 0)
	{
		perror("open infile");
		return (1);
	}
	printf("Type something\n");
	write(1, "read: ", 6);
	r_ret = read(0, buf, sizeof(buf)-1);
	print_read(r_ret, buf, "read");
	printf("read from file:\n");
	r_ret = read(fd, buf, sizeof(buf)-1);
	print_read(r_ret, buf, "read from file");
	close(fd);
	printf("\n");
		
	printf("\n===== BONUS TESTS =====\n");

	// ft_atoi_base
	printf("------ ft_atoi_base -------\n");
	printf("Base 10: %d\n", ft_atoi_base("42", "0123456789"));
	printf("Base 2: %d\n", ft_atoi_base("  101010", "01"));
	printf("Base 4: %d\n", ft_atoi_base(" +222", "0123"));
	printf("Base 8: %d\n", ft_atoi_base("\t -52", "01234567"));
	printf("Base 16: %d\n", ft_atoi_base(" \t 2As", "0123456789ABCDEF"));
	printf("Invalid base (repeated chars): %d\n", ft_atoi_base("42", "0123401234"));
	printf("Invalid base (only one char): %d\n", ft_atoi_base("42", "0"));
	printf("\n");

	// ft_list_push_front
	printf("--- ft_list_push_front ----\n");
	dup = ft_strdup("First");
	dup2 = ft_strdup("Second");
	dup3 = ft_strdup("Third");
	ft_list_push_front(&list, dup);
	ft_list_push_front(&list, dup2);
	ft_list_push_front(&list, dup3);
	print_list(list);
	printf("\n");

	// ft_list_size
	printf("------ ft_list_size -------\n");
	printf("List size: %d\n", ft_list_size(list));
	printf("\n");

	// ft_list_sort
	printf("------ ft_list_sort -------\n");
	ft_list_sort(&list, (int (*)(const void *, const void *))strcmp);
	print_list(list);
	printf("\n");

	// ft_list_remove_if
	printf("---- ft_list_remove_if ----\n");
	ft_list_remove_if(&list, "Second", (int (*)(const void *, const void *))strcmp, free);
	print_list(list);
	printf("\n");

	while (list)
	{
		t_list *tmp = list;
		list = list->next;
		free(tmp->data);
		free(tmp);
	}

	return (0);
}