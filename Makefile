NAME = libasm.a

SRCS = ft_strlen ft_strcpy ft_strcmp ft_write ft_read ft_strdup

BONUS = ft_atoi_base ft_list_push_front ft_list_size ft_list_sort ft_list_remove_if

OBJS = ${SRCS:.s=.o}

OBJS_BON = ${BONUS:.s=.o}

CC = nasm

RM = rm -f

FLAGS = -f elf64 -g

.s.o: 
	${CC} ${FLAGS} $< -o ${<:.s=.o}

$(NAME): ${OBJS}
	ar rcs ${NAME} ${OBJS}

bonus: ${OBJS_BON}
	ar rcs ${NAME} ${OBJS_BON}	

all: ${NAME}

clean: 
	${RM} ${OBJS} ${OBJS_BON}

fclean: clean 
	${RM} ${NAME}

re: fclean all

.PHONY: all clean fclean re bonus