#include "libasm.h"

void print_strlen(const char *s) {
	printf("ft_strlen: %lu\t", ft_strlen(s));
	printf(" | ");
	printf("strlen: %lu\n", strlen(s));
}

void print_strcpy(char *dest, const char *src) {
	char *tab = strcmp(src, "") ? "" : "\t\t";

	printf("ft_strcpy: %s", ft_strcpy(dest, src));
	printf("%s | ", tab);
	printf("strcpy: %s\n", strcpy(dest, src));
}

void print_strcmp(const char *s1, const char *s2) {
	char *diff_str = strcmp(s1, s2) ? " (diff)" : "";
	char *tab = strcmp(s1, s2) ? "\t" : "\t\t";

	printf("ft_strcmp%s: %d\t", diff_str, ft_strcmp(s1, s2));
	printf("%s | ", tab);
	printf("strcmp%s: %d\n", diff_str, strcmp(s1, s2));
}

void print_errno(int err, int err2) {
	if (err != 0 || err2 != 0) {
		printf("errno: %d (%s)", err, strerror(err));
		printf("\t | ");
		printf("errno: %d (%s)\n", err2, strerror(err2));
		errno = 0;
	}
}

void print_returns(ssize_t ret, ssize_t ret2) {
	printf("Return value: %ld", ret);
	printf("\t\t | ");
	printf("Return value: %ld\n", ret2);
}

int open_fd_write(const char *file) {
	int fd = open(file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd < 0) {
		perror("open outfile");
		exit(1);
	}
	return fd;
}

void print_write_aux(ssize_t w_ret, ssize_t w_ret2, int err, int err2) {
	print_returns(w_ret, w_ret2);
	print_errno(err, err2);
	printf("\n");
}

void print_write(char *str, char *file, char *file2, char *s, int fd, int fd2) {
	ssize_t	w_ret;
	ssize_t	w_ret2;
	int		err;
	int		err2;

	if (fd == 1)
		write(1, "ft_write: ", 10);
	else
		printf("ft_write: (%s%s)\t\t", str, file);
	w_ret = ft_write(fd, s, strlen(s));
	err = errno;
	if (fd2 == 1)
		write(1, "\t\t | write: ", 12);
	else {
		printf(" | ");
		printf("write: (%s%s)\n", str, file2);
	}
	w_ret2 = write(fd2, s, strlen(s));
	err2 = errno;
	if (fd2 == 1)
		write(1, "\n", 1);
	print_write_aux(w_ret, w_ret2, err, err2);
}

int open_fd_read(const char *file) {
	int fd = open(file, O_RDONLY);
	if (fd < 0) {
		perror("open infile");
		exit(1);
	}
	return fd;
}

void print_read_aux(ssize_t r_ret, ssize_t r_ret2, int err, int err2, char *buf, char *buf2) {
	buf[r_ret] = '\0';
	buf2[r_ret2] = '\0';

	printf("Buffer: %s", buf);
	printf("\t\t | ");
	printf("Buffer: %s\n", buf2);

	print_returns(r_ret, r_ret2);
	print_errno(err, err2);
	printf("\n");
}

void print_read(char *str, char *file, int fd, int fd2) {
	ssize_t	r_ret;
	ssize_t	r_ret2;
	int		err;
	int		err2;
	char	buf[50];
	char	buf2[50];

	if (fd == 0)
		write(1, "ft_read: ", 9);
	else
		printf("ft_read: (%s%s)      \t", str, file);
	
	r_ret = ft_read(fd, buf, sizeof(buf)-1);
	err = errno;
	if (fd2 == 0)
		write(1, "\t\t | read: ", 11);
	else {
		printf(" | ");
		printf("read: (%s%s)\n", str, file);
	}
	r_ret2 = read(fd2, buf2, sizeof(buf2)-1);
	err2 = errno;
	if (fd2 == 0)
		write(1, "\n", 1);
	print_read_aux(r_ret, r_ret2, err, err2, buf, buf2);
}

void print_strdup(char *s) {
	char *dup = ft_strdup(s);
	char *dup2 = strdup(s);
	char *tab = strcmp(s, "") ? "" : "\t\t";

	printf("ft_strdup: %s", dup);
	printf("%s | ", tab);
	printf("strdup: %s\n", dup2);
	free(dup);
	free(dup2);
}

void print_list(t_list *list) {
	t_list *tmp = list;
	while (tmp) {
		printf("Node data: %s\n", (char *)tmp->data);
		tmp = tmp->next;
	}
}

void free_list(t_list *list) {
	while (list) {
		t_list *tmp = list;
		list = list->next;
		free(tmp->data);
		free(tmp);
	}
}

int main() {
	char	src[] = "Hello, world!";
	char	*src2 = "";
	char	dest[20];

	char	*file = "test.txt";
	char	*file2 = "test2.txt";
	int		fd;
	int		fd2;

	t_list	*list = NULL;

	errno = 0;

	printf("===== MANDATORY TESTS =====\n");

	// ft_strlen
	printf("-------- ft_strlen --------\n");
	print_strlen(src);
	print_strlen(src2);
	printf("\n");

	// ft_strcpy
	printf("-------- ft_strcpy --------\n");
	print_strcpy(dest, src);
	print_strcpy(dest, src2);
	printf("\n");

	// ft_strcmp
	printf("-------- ft_strcmp --------\n");
	strcpy(dest, src);
	print_strcmp(src, dest);
	print_strcmp(src, "Hello");
	print_strcmp(src, src2);
	printf("\n");

	// ft_write
	printf("-------- ft_write ---------\n");
	print_write("", "", "", src, 1, 1);

	fd = open_fd_write(file);
	fd2 = open_fd_write(file2);
	print_write("in ", file, file2, src, fd, fd2);
	close(fd);
	close(fd2);

	print_write("wrong fd", "", "", src, 12, 12);

	// ft_read
	printf("--------- ft_read ---------\n");
	print_read("", "", 0, 0);

	fd = open_fd_read(file);
	fd2 = open_fd_read(file);
	print_read("from ", file, fd, fd2);
	close(fd);
	close(fd2);

	print_read("wrong fd", "", 12, 12);

	// ft_strdup
	printf("-------- ft_strdup --------\n");
	print_strdup(src);
	print_strdup(src2);
	printf("\n");
		
	printf("===== BONUS TESTS =====\n");

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
	ft_list_push_front(&list, strdup("First"));
	ft_list_push_front(&list, strdup("Second"));
	ft_list_push_front(&list, strdup("Third"));
	ft_list_push_front(&list, strdup("Fourth"));
	ft_list_push_front(&list, strdup("Fifth"));
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

	free_list(list);

	return (0);
}