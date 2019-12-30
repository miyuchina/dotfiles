home_configs = bash bspwm dunst fonts git gtk nvim polybar ranger redshift rofi sxhkd xorg

vim_dir = $(HOME)/.local/share/nvim
vim_plug_dir = $(vim_dir)/plugged
vim_plug_file = $(vim_dir)/site/autoload/plug.vim 
vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

color_red = \033[1;31m
color_yellow = \033[1;33m
color_blue = \033[1;34m
color_clear = \033[0m

.PHONY: install
install: home vim_plug

.PHONY: clean
clean: clean_home clean_vim_plug

.PHONY: home
home:
	@echo -e "$(color_yellow)Installing dotfiles to home...$(color_clear)"
	stow --verbose --target $(HOME) $(home_configs)
	@echo -e "$(color_yellow)Installed dotfiles to home!$(color_clear)"

.PHONY: clean_home
clean_home:
	@echo -e "$(color_red)Removing dotfiles from home...$(color_clear)"
	stow --verbose --target $(HOME) --delete $(home_configs)
	@echo -e "$(color_red)Removed dotfiles from home!$(color_clear)"

.PHONY: vim_plug
vim_plug:
	@echo -e "$(color_blue)Installing vim-plug to: $(vim_plug_file)$(color_clear)"
	@echo -e "$(color_yellow)Installing vim-plug...$(color_clear)"
	[ -f $(vim_plug_file) ] || \
	    curl --output $(vim_plug_file) --create-dirs $(vim_plug_url)
	@echo -e "$(color_yellow)Finishing install in nvim...$(color_clear)"
	nvim +PlugUpgrade +PlugInstall +quitall
	@echo -e "$(color_yellow)Installed vim-plug!$(color_clear)"

.PHONY: clean_vim_plug
clean_vim_plug:
	@echo -e "$(color_red)Removing vim-plug...$(color_clear)"
	[ -f $(vim_plug_file) ] && \
	    rm --verbose $(vim_plug_file)
	[ -d $(vim_plug_dir) ] && \
	    rm -rf $(vim_plug_dir)
	@echo -e "$(color_red)Removed vim-plug.$(color_clear)"
