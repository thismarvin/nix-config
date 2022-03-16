# TODO(thimarvin): Switch to zsh and automatically launch nushell?

{ config, pkgs, ... }:

let
	corePackages = with pkgs; [
		curl
		gcc
		neovim
	];
	essentialPackages = with pkgs; [
		bat
		bottom
		du-dust
		fd
		fzy
		git
		gitui
		ripgrep
		sd
	];
in

{
	imports = [
		./hardware-configuration.nix
	];

	nix = {
		package = pkgs.nixUnstable;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	nixpkgs.config.allowUnfree = true;

	# Use the systemd-boot EFI boot loader.
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	time.timeZone = "America/Chicago";

	networking = {
		hostName = "nixos";
		wireless.enable = true;
	};

	# The global useDHCP flag is deprecated, therefore explicitly set to false here.
	# Per-interface useDHCP will be mandatory in the future, so this generated config
	# replicates the default behaviour.
	networking.useDHCP = false;
	networking.interfaces.enp2s0.useDHCP = true;

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Enable the X11 windowing system.
	services.xserver = {
		enable = true;
		videoDrivers = [ "nvidia" ];
		desktopManager.xfce.enable = true;
	};

	# Enable Sound
	services.pipewire = {
		enable = true;
		alsa = {
			enable = true;
		};
		pulse = {
			enable = true;
		};
		jack = {
			enable = true;
		};
	};

	users.users.marvin = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		shell = pkgs.nushell;
	};

	# List packages installed in system profile.
	environment.systemPackages = corePackages ++ essentialPackages;

	hardware = {
		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
		};
		steam-hardware.enable = true;
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	system.stateVersion = "21.11"; # Did you read the comment?
}
