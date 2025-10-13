NAME = libasm.a

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s

BONUS = ft_atoi_base.s ft_list_push_front.s ft_list_size.s ft_list_sort.s ft_list_remove_if.s

OBJS = ${SRCS:.s=.o}

OBJS_BON = ${BONUS:.s=.o}

CC = nasm

RM = rm -f

FLAGS = -f elf64 -g

CFLAGS = -g -Wall -Wextra -Werror

EXE = main

.s.o: 
	${CC} ${FLAGS} $< -o ${<:.s=.o}

$(NAME): ${OBJS}
	ar rcs ${NAME} ${OBJS}

test: main.c $(NAME)
	gcc ${CFLAGS} main.c -L. -lasm -o ${EXE}

bonus: ${OBJS_BON}
	ar rcs ${NAME} ${OBJS_BON}	

mandatory: ${NAME} bonus test 
	./${EXE}

all: ${NAME} bonus test 
	./${EXE} all

clean: 
	${RM} ${OBJS} ${OBJS_BON}

fclean: clean 
	${RM} ${NAME}
	${RM} ${EXE}

re: fclean all

.PHONY: all clean fclean re bonus