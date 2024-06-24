NAME = libftprintf.a
CC = cc
CFLAGS = -Wall -Wextra -Werror
FILES = $(shell find . -type f -name "*.c" | wc -l | sed 's/^[[:space:]]*//;s/[[:space:]]*$$//')
CALC = $(shell echo $$((($(COUNT) * 100) / $(FILES))))
RESETLINE = \r\033[K
BLUE = \033[1;34m
YELLOW = \033[0;33m
RED = \033[0;31m
DEF_COLOR = \033[0m
COUNT = 1
SRCS = ft_printf.c \
		ft_printvalue.c \
		ft_helper.c \
		ft_helper_helper.c
OBJS = $(SRCS:.c=.o)

$(NAME):		msg_mand $(OBJS)
				@ar rc $(NAME) $(OBJS)

all:			$(NAME)

%.o:%.c
				@cc -c $^ -o $@ $(CFLAGS)
				@echo "$(RESETLINE)$(BLUE)$@ $(COUNT)/$(FILES) $(CALC)/100%$(DEF_COLOR)\c"
				@if [ $(COUNT) -eq $(FILES) ]; then echo ""; fi
				$(eval COUNT := $(shell echo $$(($(COUNT) + 1))))

clean:
				@echo "$(BLUE)Printf:$(DEF_COLOR) $(RED)Cleaning object files...$(DEF_COLOR)"
				@rm -f $(OBJS)

fclean:			clean
				@echo "$(BLUE)Printf:$(DEF_COLOR) $(RED)Cleaning executable files...$(DEF_COLOR)"
				@rm -f $(NAME)

re: fclean all

reset:
			$(eval COUNT := 1)

msg_mand:
			@echo "$(YELLOW)Compiling Printf Mandotory$(DEF_COLOR)"

msg_bonus:
			@echo "$(YELLOW)Compiling Printf Bonus$(DEF_COLOR)"

.PHONY: all clean fclean re