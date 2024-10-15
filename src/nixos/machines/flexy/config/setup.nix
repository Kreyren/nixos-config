{ config, lib, ... }:

# Setup of FLEXY

let
	inherit (lib) mkIf;
in {
	networking.hostName = "flexy";

	boot.impermanence.enable = true; # Use impermanence

	# FIXME(Krey): Turn this on when reasonable
	boot.plymouth.enable = false;

	nix.distributedBuilds = true; # Perform distributed builds

	programs.noisetorch.enable = true;
	programs.adb.enable = true;

	services.openssh.enable = true;
	services.tor.enable = true;

	virtualisation.waydroid.enable = true;

	nix.channel.enable = true; # To be able to use nix repl :l <nixpkgs> as loading flake loads only 16 variables

	# Desktop Environment
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
		programs.dconf.enable = true; # Needed for home-manager to not fail deployment (https://github.com/nix-community/home-manager/issues/3113)

	users.users.root.openssh.authorizedKeys.keys = mkIf config.services.openssh.enable [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzh6FRxWUemwVeIDsr681fgJ2Q2qCnwJbvFe4xD15ve kreyren@fsfe.org" # Allow root access for the Super Administrator (KREYREN)
	];

	age.secrets.flexy-ssh-ed25519-private.file = ../secrets/flexy-ssh-ed25519-private.age; # Declare private key

	nixpkgs.hostPlatform = "x86_64-linux";
}
