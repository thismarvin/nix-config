{ config, lib, pkgs, ... }:
{
	programs.home-manager.enable = true;

# home.stateVersion = "21.05";
	home.stateVersion = "20.09";

	home.packages = with pkgs; [
		firefox
		kitty #
		neovim-nightly
		nushell #

		pavucontrol

		git #
		gnumake

		starship #
		delta #
		gh #
		gitui
		exa #
		bat #
		fd
		ripgrep
		sd
		bottom #
		du-dust
		fzy
		zoxide #
		broot #
# nnn #

		deno

		fira-code
		cascadia-code

		bitwarden
		thunderbird
	];

	programs.zsh = {
		enable = true;
		dotDir = ".config/zsh";
		sessionVariables = {
			TERMINAL = "kitty";
			EDITOR = "nvim";
		};
		shellAliases = {
			".." = "cd ..";
			"v" = "${pkgs.neovim}/bin/nvim";
			"n" = "${pkgs.nnn}/bin/nnn -Reo";
		};
		defaultKeymap = "viins";
		initExtra = lib.concatStrings [
			"zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'\n"
		];
	};

	programs.nushell = {
		enable = true;
	};

	programs.git = {
		enable = true;
		userName = "marvin";
		userEmail = "marvin@thismarvin.com";
		delta = {
			enable = true;
			options = {
				line-numbers = true;
			};
		};
		extraConfig = {
			init = {
				defaultBranch = "dev";
			};
		};
	};

	programs.gh = {
		enable = true;
	};

	programs.kitty = {
		enable = true;
		settings = {
			font_size = 10;

			font_family = "Cascadia Code SemiBold";
			bold_font = "Cascadia Code Bold";
			italic_font = "Cascadia Code SemiBold Italic";
			bold_italic_font = "Cascadia Code Bold Italic";

			window_padding_width = 8;
			# tab_bar_style = "powerline";

			background = "#1a1b26";
			foreground = "#c0caf5";
			selection_background = "#33467C";
			selection_foreground = "#c0caf5";
			url_color = "#73daca";
			cursor = "#c0caf5";

			active_tab_background = "#7aa2f7";
			active_tab_foreground = "#1f2335";
			inactive_tab_background = "#292e42";
			inactive_tab_foreground = "#545c7e";

			color0 = "#15161E";
			color1 = "#f7768e";
			color2 = "#9ece6a";
			color3 = "#e0af68";
			color4 = "#7aa2f7";
			color5 = "#bb9af7";
			color6 = "#7dcfff";
			color7 = "#a9b1d6";
			color8 = "#414868";
			color9 = "#f7768e";
			color10 = "#9ece6a";
			color11 = "#e0af68";
			color12 = "#7aa2f7";
			color13 = "#bb9af7";
			color14 = "#7dcfff";
			color15 = "#c0caf5";
			color16 = "#ff9e64";
			color17 = "#db4b4b";
		};
	};

	programs.starship = {
		enable = true;
		settings = {
			add_newline = false;

			format = lib.concatStrings [
				"$time"
				"$directory"
				"$git_branch"
				"$git_status"
				"$character"
			];

			time = {
				disabled = false;
				format = "\\[[$time]($style)\\]";
				style = "yellow";
				time_format = "%T";
			};

			directory = {
				format = "\\[[$path]($style)\\]";
				style = "green";
			};

			git_branch = {
				format = " [$symbol$branch]($style)";
				style = "bright-white";
			};

			git_status = {
				format = "( [\\[$all_status$ahead_behind\\]]($style))";
				ahead = "⇡$count";
				behind = "⇣$count";
				diverged = "⇕⇡$ahead_count⇣$behind_count";
			};

			character = {
				format = " $symbol ";
				success_symbol = "[=>](green)";
				error_symbol = "[=>](red)";
				vicmd_symbol = "[<-](yellow)";
			};
		};
	};

	programs.broot = {
		enable = true;
	};

	programs.nnn = {
		enable = true;
	};

	programs.bottom = {
		enable = true;
	};

	programs.zoxide = {
		enable = true;
	};

	programs.exa = {
		enable = true;
		enableAliases = true;
	};

	programs.bat = {
		enable = true;
		config = {
			theme = "ansi";
		};
	};

	xdg.configFile."nvim/init.lua".source = ./dotfiles/nvim/init.lua;
}
