{ self, pkgs, config, lib, ... }:

# MORPH-specific configuration of Sunshine

let
	inherit (lib) mkIf;
in mkIf config.services.sunshine.enable {
	services.sunshine.capSysAdmin = true; # Assign CAP_SYS_ADMIN for DRM/KMS screen capture

	services.sunshine.openFirewall = true; # Open Firewall for local network

	# Declare the expected applications
	# services.sunshine.applications = {
	# 	env = {
	# 		PATH = "$(PATH):$(HOME)/.local/bin";
	# 	};
	# 	apps = [
	# 		{
	# 			name = "1440p Desktop";
	# 			prep-cmd = [
	# 				{
	# 					do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-4.mode.2560x1440@144";
	# 					undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-4.mode.3440x1440@144";
	# 				}
	# 			];
	# 			exclude-global-prep-cmd = "false";
	# 			auto-detach = "true";
	# 		}
	# 	];
	# };
}
