{ config, ... }:

let
	inherit (config.flake) homeManagerModules;
in {
	flake.homeManagerModules.kira.imports = [{
		home-manager.users.kira.imports = [
			./home.nix

			# FIXME-QA(Krey): Expected to be just `homeManagerModules.editors-kira` same for all others..
			homeManagerModules.editors-vim-kira
			homeManagerModules.editors-vscode-kira

			#homeManagerModules.prompts-kira
			homeManagerModules.prompts-starship-kira

			# homeManagerModules.kira.shells.default
			homeManagerModules.shells-bash-kira
			homeManagerModules.shells-nushell-kira

			# homeManagerModules.kira.system.default
			homeManagerModules.system-dconf-kira
			homeManagerModules.system-gtk-kira

			# homeManagerModules.kira.terminal-emulators.default
			homeManagerModules.terminal-emulators-alacritty-kira

			# homeManagerModules.kira.tools.default
			homeManagerModules.tools-direnv-kira
			homeManagerModules.tools-git-kira
			homeManagerModules.tools-gpg-agent-kira

			# homeManagerModules.kira.web-browsers.default
			# homeManagerModules.web-browsers-firefox-kira # Broken
			homeManagerModules.web-browsers-librewolf-kira
		];
	}];

	imports = [
		./machines
		./modules
	];
}
