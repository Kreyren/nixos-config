# Standalone ragenix secret declaration

let
	# Users
	kreyren = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOzh6FRxWUemwVeIDsr681fgJ2Q2qCnwJbvFe4xD15ve";
	# kira = "ssh-ed25519 ...";

	# Systems
	mracek-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP8d9Nz64gE+x/+Dar4zknmXMAZXUAxhF1IgrA9DO4Ma";
	pelagus-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhxI+25BwlCuEezW6Vc4mJ+EP/KO597PI2YfEU9t+vf";
	sinnenfreude-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIAXnS4xUPWwjBdKDvvy5OInLbs3oeHUUs5qUsX+fBji";
	tsvetan-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGEoubO6sCsZf8vGSqWBLurJB1aSL3nMS+QFWulmF/n8";
	tupac-system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmYpmNkpSkSSk1FnxHvPb8JlbeYh2lf3d5u8MBqGpHP";

	all-systems = [
		mracek-system
		pelagus-system
		sinnenfreude-system
		tsvetan-system
		tupac-system
	];
in {
	# Kreyren (user)
	"./users/kreyren/kreyren-user-password.age".publicKeys = [
		kreyren
	] ++ all-systems;

	# MRACEK (system)
	"./machines/mracek/secrets/mracek-disks-password.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-onion-gitea-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-openssh-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/mracek/secrets/mracek-onion-vikunja-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-vikunja-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/mracek/secrets/mracek-onion-monero-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-gitea-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/mracek/secrets/mracek-onion-murmur-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-monero-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/mracek/secrets/mracek-monero-p2p-onion.age".publicKeys = [
		kreyren
	] ++ all-systems; # Onion Address for Monero's P2P Onion Service

	"./machines/mracek/secrets/mracek-onion-monero-p2p-private.age".publicKeys = [
		kreyren mracek-system
	]; # Private Key for Monero's P2P Onion Service

	"./machines/mracek/secrets/mracek-murmur-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/mracek/secrets/mracek-onion-navidrome-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-navidrome-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/mracek/secrets/mracek-ssh-ed25519-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-onion-openssh-private.age".publicKeys = [
		kreyren mracek-system
	];

	"./machines/mracek/secrets/mracek-builder-ssh-ed25519-private.age".publicKeys = [
		kreyren mracek-system
	];

	# PELAGUS (system)
	"./machines/pelagus/secrets/disks-password.age".publicKeys = [
		kreyren pelagus-system
	];
	"./machines/pelagus/secrets/pelagus-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	# SINNENFREUDE (system)
	"./machines/sinnenfreude/secrets/sinnenfreude-disks-password.age".publicKeys = [
		kreyren sinnenfreude-system
	];

	"./machines/sinnenfreude/secrets/sinnenfreude-onion.age".publicKeys = [
		kreyren
	] ++ all-systems;

	"./machines/sinnenfreude/secrets/sinnenfreude-ssh-ed25519-private.age".publicKeys = [
		kreyren sinnenfreude-system
	];

	"./machines/sinnenfreude/secrets/sinnenfreude-onion-openssh-private.age".publicKeys = [
		kreyren sinnenfreude-system
	];

	"./machines/sinnenfreude/secrets/sinnenfreude-builder-ssh-ed25519-private.age".publicKeys = [
		kreyren sinnenfreude-system
	];

	# TSVETAN (system)
	"./machines/tsvetan/secrets/tsvetan-disks-password.age".publicKeys = [
		kreyren tsvetan-system
	];

	"./machines/tsvetan/secrets/tsvetan-ssh-ed25519-private.age".publicKeys = [
		kreyren tsvetan-system
	];

	# TUPAC (system)
	"./machines/tupac/secrets/disks-password.age".publicKeys = [
		kreyren tupac-system
	];
	"./machines/tupac/secrets/tupac-onion.age".publicKeys = [
		kreyren tupac-system
	];
	"./machines/tupac/secrets/tupac-onion-secretKey.age".publicKeys = [
		kreyren tupac-system
	];

	# WiFi
	"./modules/system/wifi/homeBaseKreyren-WiFi-PSK.age".publicKeys = [
		kreyren
	] ++ all-systems;
}
