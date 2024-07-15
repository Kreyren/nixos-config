{ ... }:

# The REPL Task

{
	perSystem = {
		mission-control.scripts = {
			"repl" = {
				description = "Open REPL";
				category = "Administration";
				exec = ''
					nix repl --expr "builtins.getFlake "$FLAKE_ROOT"
				'';
			};
		};
	};
}
