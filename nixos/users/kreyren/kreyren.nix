{ config, lib, ... }:

# Module that is going to set up the KREYREN user

let
	inherit (lib) mkIf mkForce;
in {
	users.users.kreyren = {
		description = "Raptor"; # FIXME(Krey): Figure out how to handle this
		isNormalUser = true;
		hashedPasswordFile = config.age.secrets.kreyren-user-password.path;
		extraGroups = [
			"wheel"
			(mkIf config.virtualisation.docker.enable "docker")
			"dialout" # To Access e.g. /dev/ttyUSB0 for USB debuggers
		];
		openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzh6FRxWUemwVeIDsr681fgJ2Q2qCnwJbvFe4xD15ve kreyren@fsfe.org" ];
	};

	users.users.root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzh6FRxWUemwVeIDsr681fgJ2Q2qCnwJbvFe4xD15ve kreyren@fsfe.org" ]; # Allow root access for all systems

	age.secrets.kreyren-user-password.file = ./kreyren-user-password.age;
}
