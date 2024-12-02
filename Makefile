NAME = libftprintf.a
CFLAGS = -Wall -Werror -Wextra
SRC = ft_printf.c \
		ft_printvalue.c \
		ft_helper.c \
		ft_helper_helper.c

OBJDIR = objs/
OBJ = $(SRC:.c=.o)
OBJS_PATH = $(addprefix $(OBJDIR), $(OBJ))

$(NAME):	logo $(OBJS_PATH)
			@ar rc $(NAME) $(OBJS_PATH)

all:		$(OBJDIR) $(NAME)

$(OBJDIR)%.o: %.c | $(OBJDIR)
			@mkdir -p $(dir $@)
			@cc -c $< -o $@ $(CFLAGS)
			@if [ "$(filter $<,$(SRC))" ]; then $(MAKE) progress; fi

$(OBJDIR):
			@mkdir -p $(OBJDIR)

progress:
			@$(eval PROGRESS := $(shell echo $$(($(shell find $(SRC) -name '*.c' | wc -l) - $$(find $(OBJDIR) -name '*.o' | wc -l)))))
			@$(eval TOTAL := $(shell find $(SRC) -name '*.c' | wc -l))
			@$(eval PERCENT := $(shell echo "scale=2; (1 - $(PROGRESS) / $(TOTAL)) * 100" | bc))
			@$(eval BAR := $(shell printf '=%.0s' {1..$(shell echo "scale=0; $(PERCENT) / 2" | bc)}))
			@printf "\r[%-50s] %s%%" "$(BAR)" "$(PERCENT)"
			@if [ "$(PERCENT)" = "100.00" ]; then printf "\n"; fi
			@if [ "$(PERCENT)" = "100.00" ]; then printf "\033[0;32mprintf mandotory compiled\033[0m\n"; fi

clean:
			@rm -rf $(OBJDIR)

fclean:		clean
			@rm -f $(NAME)

re: fclean all

logo:
			@echo "  ___ ___ ___ _  _ _____ ___ "
			@echo " | _ \ _ \_ _| \| |_   _| __|"
			@echo " |  _/   /| || .  | | | | _| "
			@echo " |_| |_|_\___|_|\_| |_| |_|  "
			@echo "                             "

.PHONY: all clean fclean re progress logo