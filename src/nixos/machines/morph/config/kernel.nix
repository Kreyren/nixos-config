{ ... }:

# Kernel Management of MORPH

{
	boot.kernelModules = [
		"kvm-amd" # Use KVM
	];

	boot.extraModulePackages = [ ];
}
