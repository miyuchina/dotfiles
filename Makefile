home_configs = bash bspwm fonts git nvim sxhkd tmux xinit

terminal_git_url = 'https://git.suckless.org/st'
terminal_git_dir = 'st-git'
terminal_patch_urls = \
    'https://st.suckless.org/patches/vertcenter/st-vertcenter-20180320-6ac8c8a.diff' \
    'https://st.suckless.org/patches/scrollback/st-scrollback-20190331-21367a0.diff'
terminal_config = st

wallpaper_url = 'https://images.unsplash.com/photo-1519334216607-0a0f0ed992cb'
wallpaper_dir = $(HOME)/Pictures
wallpaper_target = $(wallpaper_dir)/wallpaper.jpg
wallpaper_script = $(HOME)/.fehbg

acpi_dir = /etc/acpi
acpi_config = acpi

.PHONY : home
home :
	stow --verbose --target $(HOME) $(home_configs)

clean_home :
	stow --verbose --target $(HOME) --delete $(home_configs)

.PHONY : terminal
terminal :
	[ -d $(terminal_git_dir) ] || \
	    git clone $(terminal_git_url) $(terminal_git_dir)
	stow --verbose --target $(terminal_git_dir) $(terminal_config)
	cd $(terminal_git_dir) && \
	    for patch_url in $(terminal_patch_urls); do  \
		patch="$$(basename "$${patch_url}")" &&  \
		[ -f "$${patch}" ] || (                  \
		    wget --no-verbose "$${patch_url}" && \
		    git apply "$${patch}"                \
		)                                        \
	    done &&                                      \
	    make && sudo make install

.PHONY : clean_terminal
clean_terminal :
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
		make clean && sudo make uninstall

.PHONY : wallpaper
wallpaper :
	[ -d $(wallpaper_dir) ] || \
	    mkdir --verbose $(wallpaper_dir)
	[ -f $(wallpaper_target) ] || \
	    wget --no-verbose --output-document $(wallpaper_target) $(wallpaper_url)
	[ -x $(wallpaper_script) ] || \
	    feh --bg-fill $(wallpaper_target)

.PHONY : clean_wallpaper
clean_wallpaper :
	rm --verbose $(wallpaper_target)
	rm --verbose $(wallpaper_script)

.PHONY : acpi
acpi :
	sudo stow --verbose --target $(acpi_dir) $(acpi_config)

.PHONY : clean_acpi
clean_acpi :
	sudo stow --verbose --target $(acpi_dir) --delete $(acpi_config)
