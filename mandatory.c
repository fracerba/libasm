#include "libasm.h"

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
	ssize_t w_ret, r_ret;
	char	buf[50];
	int	 cmp, fd;

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

	return (0);
}
