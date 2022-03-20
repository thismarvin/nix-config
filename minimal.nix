{ config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

	nix = {
		package = pkgs.nixUnstable;
		extraOptions = ''
			experimental-features = nix-command flakes
		'';
	};

	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	time.timeZone = "America/Chicago";

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	networking.useDHCP = false;
	networking.interfaces.enp2s0.useDHCP = true;

	services.xserver = {
		enable = true;
		desktopManager.xfce.enable = true;
	};

	users.users.marvin = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
	};

	environment.systemPackages = with pkgs; [
		curl
		firefox
		git
		neovim
	];

	system.stateVersion = "21.11";
}
