{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "marvin";
  home.homeDirectory = "/home/marvin";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # nxengine-evo # Unfree
    bat
    bitwarden
    bottom
    dolphin-emu-beta
    du-dust
    element-desktop
    emacs
    exa
    fd
    firefox
    fzy
    genact
    gh
    git
    gitui
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
    neovim
    nnn
    nushell
    pavucontrol
    ripgrep
    sameboy
    sd
    stockfish
    thunderbird
    ungoogled-chromium
    zoxide
  ];

  programs = {
    # firefox = {
    #   enable = true;  
    #   profiles = {
    #     default = {
    #       userChrome = ''
    #         #TabsToolbar {
    #           visibility: collapse !important;
    #         }
    #       '';
    #     };
    #   };
    # };
    kitty = {
      enable = true;
      environment = {
        "EDITOR" = "${pkgs.neovim}/bin/nvim";
        "MANPAGER" = "${pkgs.neovim}/bin/nvim +Man!";
      };
      settings = {
        font_size = "10";
        font_family = "JetBrainsMono-Bold";
        background_opacity = "0.9";
        window_padding_width = "8";
        tab_bar_style = "powerline";
        enabled_layouts = "vertical,horizontal";
	# shell_integration = "disabled";
      };
      keybindings = {
        "kitty_mod+t" = "launch --cwd=current --type=tab";
        "kitty_mod+n" = "launch --cwd=current";
        "kitty_mod+enter" = "new_os_window";
      };
      extraConfig = ''
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
    helix = {
      enable = true;
      settings = {
        theme = "dark_plus";
        editor = {
          line-number = "relative";
          # cursor-shape = {
          #   normal = "block";    
          #   insert = "bar";    
          #   select = "underline";    
          # };
        };
        keys = {
          normal = {
          };
        };
      };   
    };
  };

  # This value determines the Home Manager release that your configuration is compatible with.
  # This helps avoid breakage when a new Home Manager release introduces backwards incompatible
  # changes.
  #
  # You can update Home Manager without changing this value. See the Home Manager release notes
  # for a list of state version changes in each release.
  home.stateVersion = "21.11";
}
