{ config, lib, ... }:

# Setup of MRACEK

let
	inherit (lib) mkIf;
in {
	networking.hostName = "mracek";

	boot.impermanence.enable = true; # Use impermanence

	boot.plymouth.enable = true;

	nix.distributedBuilds = true; # Perform distributed builds

	services.gitea.enable = true;
	services.monero.enable = true;
	services.murmur.enable = false;
	services.navidrome.enable = false;
	services.openssh.enable = true;
	services.tor.enable = true;
	services.vaultwarden.enable = false; # Testing..
	services.vikunja.enable = true;
	services.xserver.desktopManager.kodi.enable = true;

	users.users.root.openssh.authorizedKeys.keys = mkIf config.services.openssh.enable [
		"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzh6FRxWUemwVeIDsr681fgJ2Q2qCnwJbvFe4xD15ve kreyren@fsfe.org" # Allow root access for the Super Administrator (KREYREN)
	];

	age.secrets.mracek-ssh-ed25519-private.file = ../secrets/mracek-ssh-ed25519-private.age; # Declare private key

	nixpkgs.hostPlatform = "x86_64-linux";
}
