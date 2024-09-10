{ config, lib, ... }:

# Setup of MORPH

let
	inherit (lib) mkIf;
in {
	networking.hostName = "morph";

	boot.impermanence.enable = true; # Use impermanence

	boot.plymouth.enable = true;

	nix.distributedBuilds = true; # Perform distributed builds

	services.openssh.enable = true;
	services.tor.enable = true;
	services.sunshine.enable = true;

	users.users.root.openssh.authorizedKeys.keys = mkIf config.services.openssh.enable [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzh6FRxWUemwVeIDsr681fgJ2Q2qCnwJbvFe4xD15ve kreyren@fsfe.org" # Allow root access for the Super Administrator (KREYREN)
	];

	age.secrets.morph-ssh-ed25519-private.file = ../secrets/morph-ssh-ed25519-private.age; # Declare private key

	# Desktop Environment
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
		programs.dconf.enable = true; # Needed for home-manager to not fail deployment (https://github.com/nix-community/home-manager/issues/3113)

	hardware.steam-hardware.enable = false; # Compatibility for Steam Controller

	hardware.enableRedistributableFirmware = true; 	# There should be nothing on this system that needs proprietary firmware, but the user likely uses proprietary peripherals

	hardware.cpu.intel.updateMicrocode = true; # Use the proprietary CPU microcode as the CPU won't work without it

	nixpkgs.hostPlatform = "x86_64-linux";
}
