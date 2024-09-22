{ pkgs,... }:

# The Setup of SINNENFREUDE system

{
	networking.hostName = "sinnenfreude";

	boot.impermanence.enable = true; # Use impermanence

	boot.plymouth.enable = true;

	nix.distributedBuilds = true; # Perform distributed builds

	programs.noisetorch.enable = true;
	programs.adb.enable = true;

	services.flatpak.enable = true;
	services.openssh.enable = true;
	services.tor.enable = true;

	networking.wireguard.enable = false;

	virtualisation.waydroid.enable = true;
	virtualisation.docker.enable = true;

	nix.channel.enable = true; # To be able to use nix repl :l <nixpkgs> as loading flake loads only 16 variables

	# Desktop Environment
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
		programs.dconf.enable = true; # Needed for home-manager to not fail deployment (https://github.com/nix-community/home-manager/issues/3113)

	hardware.steam-hardware.enable = true;

	# Japanese Keyboard Input
	i18n.inputMethod.enabled = "fcitx5";
	i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-mozc ];

	age.secrets.sinnenfreude-ssh-ed25519-private.file = ../secrets/sinnenfreude-ssh-ed25519-private.age; # Declare private key

	# This is needed to get simplex to sync with other accounts (https://github.com/simplex-chat/simplex-chat/issues/3425#issuecomment-2336520556)
	networking.firewall.allowedTCPPorts = [ 40000 ];

	# Necessary Evil :(
	hardware.enableRedistributableFirmware = true;
	hardware.cpu.intel.updateMicrocode = true;

	nixpkgs.hostPlatform = "x86_64-linux";
}
