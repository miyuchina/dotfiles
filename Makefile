home_configs = bash bspwm fonts git nvim redshift sxhkd tmux xinit

vim_dir = $(HOME)/.local/share/nvim
vim_plug_dir = $(vim_dir)/plugged
vim_plug_file = $(vim_dir)/site/autoload/plug.vim 
vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

terminal_config = st
terminal_git_url = 'https://git.suckless.org/st'
terminal_git_dir = 'st-git'
terminal_patch_urls = \
    'https://st.suckless.org/patches/vertcenter/st-vertcenter-20180320-6ac8c8a.diff' \
    'https://st.suckless.org/patches/scrollback/st-scrollback-20190331-21367a0.diff'

acpi_config = acpi
acpi_target = /etc/acpi

wallpaper_url = 'https://images.unsplash.com/photo-1519334216607-0a0f0ed992cb'
wallpaper_dir = $(HOME)/Pictures
wallpaper_target = $(wallpaper_dir)/wallpaper.jpg
wallpaper_script = $(HOME)/.fehbg

color_red = \033[1;31m
color_yellow = \033[1;33m
color_blue = \033[1;34m
color_clear = \033[0m

.PHONY: install
install: home vim_plug terminal wallpaper wpa_supplicant

.PHONY: clean
clean: clean_home clean_vim_plug clean_terminal clean_wallpaper clean_wpa_supplicant

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

.PHONY: terminal
terminal:
	@echo -e "$(color_blue)Cloning terminal from: $(terminal_git_url)$(color_clear)"
	@echo -e "$(color_yellow)Installing terminal...$(color_clear)"
	[ -d $(terminal_git_dir) ] || \
	    git clone $(terminal_git_url) $(terminal_git_dir)
	@echo -e "$(color_yellow)Installing custom config...$(color_clear)"
	stow --verbose --target $(terminal_git_dir) $(terminal_config)
	@echo -e "$(color_yellow)Applying patches...$(color_clear)"
	cd $(terminal_git_dir) && \
	    for patch_url in $(terminal_patch_urls); do  \
		patch="$$(basename "$${patch_url}")" &&  \
		[ -f "$${patch}" ] || (                  \
		    wget --no-verbose "$${patch_url}" && \
		    git apply "$${patch}"                \
		)                                        \
	    done &&                                      \
	    make
	@echo -e "$(color_red)Enter your password!$(color_clear)"
	cd $(terminal_git_dir) && sudo make install
	@echo -e "$(color_yellow)Installed terminal!$(color_clear)"

.PHONY: clean_terminal
clean_terminal:
	@echo -e "$(color_red)Removing terminal...$(color_clear)"
	[ -d $(terminal_git_dir) ] && \
	    stow --verbose --target $(terminal_git_dir) \
		--delete $(terminal_config) && \
	    cd $(terminal_git_dir) && \
		for patch_url in $(terminal_patch_urls); do  \
		    patch="$$(basename "$${patch_url}")" &&  \
		    [ -f "$${patch}" ] || (                  \
			git apply --reverse "$${patch}" &&   \
			rm "$${patch}"                       \
		    )                                        \
		done &&                                      \
		echo -e "$(color_red)Enter your password!$(color_clear)" && \
		make clean && sudo make uninstall
	@echo -e "$(color_red)Removed terminal!$(color_clear)"

.PHONY: acpi
acpi:
	@echo -e "$(color_blue)ACPI target: $(acpi_target)$(color_clear)"
	@echo -e "$(color_yellow)Installing ACPI scripts...$(color_clear)"
	@echo -e "$(color_red)Removing directory at ACPI target...$(color_clear)"
	@echo -e "$(color_red)Enter your password!$(color_clear)"
	sudo rm --verbose -rf $(acpi_target)
	@echo -e "$(color_yellow)Copying ACPI configs...$(color_clear)"
	sudo cp --verbose --recursive $(acpi_config) $(acpi_target)
	@echo -e "$(color_yellow)ACPI scripts installed!$(color_clear)"

.PHONY: clean_acpi
clean_acpi:
	@echo -e "$(color_blue)ACPI target: $(acpi_target)$(color_clear)"
	@echo -e "$(color_red)Uninstalling ACPI scripts...$(color_clear)"
	@echo -e "$(color_red)Enter your password!$(color_clear)"
	sudo rm --verbose -rf $(acpi_target)
	@echo -e "$(color_red)Removed ACPI scripts!$(color_clear)"

.PHONY: wallpaper
wallpaper:
	@echo -e "$(color_blue)Wallpaper directory: $(wallpaper_dir)$(color_clear)"
	@echo -e "$(color_yellow)Creating wallpaper directory...$(color_clear)"
	[ -d $(wallpaper_dir) ] || \
	    mkdir --verbose $(wallpaper_dir)
	@echo -e "$(color_blue)Wallpaper target: $(wallpaper_target)$(color_clear)"
	@echo -e "$(color_blue)Wallpaper url: $(wallpaper_url)$(color_clear)"
	@echo -e "$(color_yellow)Downloading wallpaper...$(color_clear)"
	[ -f $(wallpaper_target) ] || \
	    wget --no-verbose --output-document $(wallpaper_target) $(wallpaper_url)
	@echo -e "$(color_yellow)Applying wallpaper...$(color_clear)"
	-[ -x $(wallpaper_script) ] || \
	    feh --bg-fill $(wallpaper_target)
	@echo -e "$(color_yellow)Applied wallpaper!$(color_clear)"

.PHONY: clean_wallpaper
clean_wallpaper:
	@echo -e "$(color_blue)Wallpaper target: $(wallpaper_target)$(color_clear)"
	@echo -e "$(color_red)Removing wallpaper...$(color_clear)"
	-rm --verbose $(wallpaper_target)
	@echo -e "$(color_red)Removing feh script...$(color_clear)"
	-rm --verbose $(wallpaper_script)
	@echo -e "$(color_red)Removed wallpaper!$(color_clear)"

.PHONY: wpa_supplicant
wpa_supplicant:
	@echo -e "$(color_yellow)Installing wpa_supplicant configuration...$(color_clear)"
	@echo -e "$(color_red)Enter your password!$(color_clear)"
	./utils/wifi_password.sh
	@echo -e "$(color_yellow)Installed wpa_supplicant configuration!$(color_clear)"

.PHONY: clean_wpa_supplicant
clean_wpa_supplicant:
	@echo -e "$(color_yellow)Installing wpa_supplicant configuration...$(color_clear)"
	@echo -e "$(color_red)Enter your password!$(color_clear)"
	sudo rm /etc/wpa_supplicant/wpa_supplicant.conf
	@echo -e "$(color_yellow)Installed wpa_supplicant configuration!$(color_clear)"
