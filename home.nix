{ config, pkgs, ... }:

{
	home = {
		username = "marvin";
		homeDirectory = "/home/marvin";
		stateVersion = "21.11";
		packages = with pkgs; [
			bitwarden
			dolphin-emu-beta
			element-desktop
			emacs
			exa
			fira-code
			firefox
			genact
			gh
			gnome.gnome-chess
			helix
			inkscape
			jetbrains-mono
			jitsi-meet-electron
			joplin-desktop
			kitty
			logseq
			mpv
			mupen64plus
			mypaint
			nnn
			nushell
			nxengine-evo
			pavucontrol
			polymc
			sameboy
			steamPackages.steam
			steamPackages.steam-runtime
			stockfish
			thunderbird
			ungoogled-chromium
			zoxide
			zsh
		];
	};

	programs = {
		home-manager = {
			enable = true;
		};
		kitty = {
			enable = true;
			environment = {
				"EDITOR" = "${pkgs.neovim}/bin/nvim";
				"MANPAGER" = "${pkgs.neovim}/bin/nvim +Man!";
			};
			settings = {
				font_size = "10";
				font_family = "FiraCodeRoman_700wght";
				font_features = "FiraCodeRoman_700wght +zero +ss02 +ss03 +ss04 +ss07";
				bold_font = "JetBrainsMono-ExtraBold";
				italic_font = "JetBrainsMono-Italic";
				bold_italic_font = "JetBrainsMono-ExtraBoldItalic";
				background_opacity = "0.9";
				window_padding_width = "8";
				tab_bar_style = "powerline";
				enabled_layouts = "vertical,horizontal";
			};
			keybindings = {
				"kitty_mod+t" = "launch --cwd=current --type=tab";
				"kitty_mod+n" = "launch --cwd=current";
				"kitty_mod+enter" = "new_os_window";
			};
			extraConfig = ''
				symbol_map U+0030-U+0039 JetBrainsMono-Bold
				symbol_map U+0041-U+005A JetBrainsMono-Bold
				symbol_map U+0061-U+007A JetBrainsMono-Bold
				include current-theme.conf
			'';
		};
		nushell = {
			enable = true;
			settings = {
				skip_welcome_message = true;
				startup = [
					"${pkgs.zoxide}/bin/zoxide init nushell --hook prompt | save ~/.zoxide.nu"
					"source ~/.zoxide.nu"
					"alias v = ${pkgs.neovim}/bin/nvim"
					"alias ll = ${pkgs.exa}/bin/exa -l"
					"alias lla = ${pkgs.exa}/bin/exa -la"
					"alias n = ${pkgs.nnn}/bin/nnn -deo"
					"alias d = ${pkgs.kitty}/bin/kitty +kitten diff"
				];
			};
		};
		git = {
			enable = true;
			userName = "marvin";
			userEmail = "me@thismarvin.com";
			extraConfig = {
				init = {
					defaultBranch = "dev";
				};
			};
		};
		zoxide = {
			enable = true;
			enableBashIntegration = false;
			enableZshIntegration = false;
			enableFishIntegration = false;
		};
		neovim = {
			enable = true;
			plugins = with pkgs.vimPlugins; [
				comment-nvim
				editorconfig-nvim
				lsp_extensions-nvim
				nvim-lspconfig
				nvim-treesitter
				telescope-nvim
			];
			extraConfig = ''
				lua require("stable")
			'';
		};
		helix = {
			enable = true;
			settings = {
				theme = "dark_plus";
				editor = {
					line-number = "relative";
					# cursor-shape = {
					# 	normal = "block";
					# 	insert = "bar";
					# 	select = "underline";
					# };
				};
				keys = {
					normal = {
					};
				};
			};
		};
	};

	xdg.configFile."nvim/lua/stable.lua".source = ./dotfiles/stable.lua;
}
