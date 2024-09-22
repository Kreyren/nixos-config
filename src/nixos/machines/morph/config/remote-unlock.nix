{ config, ... }:

# The Management of remote unlock for MORPH

{
	boot.initrd.network.ssh.enable = true;
	boot.initrd.network.enable = true;

	age.secrets.secrets.morph-initrd-ed25519-key = {
		file = ../secrets/morph-initrd-ed25519-key.age;

		# owner = "tor";
		# group = "tor";

		# path = "/etc/secrets/initrd/ssh_host_ed25519_key";

		# symlink = false; # Appears to not work as symlink
	};

	boot.initrd.network.ssh.hostKeys = [
		config.age.secrets.morph-initrd-ed25519-key.path
	];
}
