{ lib, config, pkgs, ... }:

# Security management of MORPH

let
	inherit (lib) mkMerge mkForce mkDefault mkIf;
in {
	config = mkMerge [
		{
			security.allowSimultaneousMultithreading = mkForce false; # Disable Simultaneous Multi-Threading as on this system it exposes unwanted attack vectors

			# Kernel
				boot.kernelPackages = mkForce pkgs.linuxPackages_hardened; # Always use the Hardened Kernel

				boot.kernelParams = mkForce [
					"tsx=auto" # Let Linux Developers determine if the mitigation is needed
					"tsx_async_abort=full,nosmt" # Enforce Full Mitigation if the management is needed
					"mds=off" # Paranoid enforcement, shouldn't be needed..
				];

			# Necessary Evil to keep the CPU microcode up-to-date, such is all i686 and amd64 architecture systems
			hardware.enableRedistributableFirmware = true;
			hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
		}

		# Enforce to use the Tor Proxy
		# (mkIf config.services.tor.enable {
		# 	networking.proxy.default = mkDefault "socks5://127.0.0.1:9050";
		# 	networking.proxy.noProxy = mkDefault "127.0.0.1,localhost";
		# })
	];
}
