NAME = libasm.a

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s

BONUS = ft_atoi_base.s ft_list_push_front.s ft_list_size.s ft_list_sort.s ft_list_remove_if.s

OBJS = ${SRCS:.s=.o}

OBJS_BON = ${BONUS:.s=.o}

CC = nasm

RM = rm -f

FLAGS = -f elf64 -g

CFLAGS = -g -Wall -Wextra -Werror

EXE = test

%.o: %.s
	${CC} ${FLAGS} $< -o $@

$(NAME): ${OBJS}
	ar rcs ${NAME} ${OBJS}

bonus: .bonus

.bonus: ${OBJS} ${OBJS_BON}
	ar rcs ${NAME} ${OBJS} ${OBJS_BON}
	touch .bonus

all: ${NAME}

test: fclean bonus
	gcc ${CFLAGS} main.c -L. -lasm -o ${EXE}
	clear
	./${EXE}

clean: 
	${RM} ${OBJS} ${OBJS_BON}

fclean: clean 
	${RM} ${NAME} .bonus
	${RM} ${EXE}

re: fclean all

.PHONY: all clean fclean re bonus test