{ config, ... }:

let
	inherit (config.flake) homeManagerModules;
in {
	# flake.homeManagerModules.kreyren.system.default = [
	# 	homeManagerModules.kreyren.system.gtk
	# 	homeManagerModules.kreyren.system.dconf
	# ];

	imports = [
		./flatpak
		./impermanence
		./nix
	];
}
