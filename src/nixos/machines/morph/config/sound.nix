{ config, lib, ... }:

# Sound management of MORPH

# NOTE(Krey): Sound is expected to never be used and only takes out power -> Disable everything

let
	inherit (lib) mkMerge mkIf;
in {
	config = mkMerge [
		(mkIf (config.system.nixos.release == "24.05") {
			sound.enable = true;

			hardware.pulseaudio.enable = false;

			services.pipewire = {
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
			};
		})

		(mkIf (config.system.nixos.release == "24.11") {
			hardware.pulseaudio.enable = false;

			services.pipewire = {
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
			};
		})

		{
			security.rtkit.enable = false; # To Get Real-Time priority for Audio
		}
	];
}
