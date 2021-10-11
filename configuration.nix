{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";

  # services.xserver.windowManager.i3.enable = true;

  # Wayland
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      waybar
      mako
      dmenu
    ];
  };

  environment = {
    etc = {
      "sway/config".source = ./dotfiles/sway/config;
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.marvin = {
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" "networkmanager" ]; 
    shell = pkgs.zsh;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
   wget
   zsh
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "21.05";
}

