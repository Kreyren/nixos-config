{ ... }:

# Bootloader management of MRACEK

{
	boot.lanzaboote.enable = false; # Whether to use NixOS's implementation of secure-boot
	boot.loader.systemd-boot.enable = true;

	boot.loader.efi.canTouchEfiVariables = true;
}
