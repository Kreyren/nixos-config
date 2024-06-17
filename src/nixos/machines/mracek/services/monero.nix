{ self, config, lib, ... }:

# Mracek-specific configuration of the Monero Node

# FIXME(Krey): Implement SSL for added security

# Reference: https://getmonero.dev/interacting/monero-config-file.html

let
	inherit (lib) mkIf;
in mkIf config.services.monero.enable {
	services.monero.rpc.restricted = true; # Prevent unsafe RPC calls

	# We are syncing over Tor, adjusted to use a reasonable limits
	services.monero.limits = {
		threads = 0; # Use all available threads
		syncSize = 0; # Maximum number of blocks to sync at once, 0 for adaptive
		upload = 1024 * 10; # megabits per second
		download = 1024 * 10; # megabits per second
	};

	# Add publicly available ID and Password to the node ensuring that only people who are aware of nixium can use it for transparency and report issues in case they find any
	services.monero.rpc = {
		user = "Monerochan";
		password = "iL0VEMoNeRoChan<3";
	};

	# FIXME-QA(Krey): Make it possible to accept list of strings for better readability without the `toString`
	# FIXME-QA(Krey): Figure out how to get a list of unsigned integers into a string `${toString config.services.tor.settings.SOCKSPort}` in `proxy` and `tx-proxy` for Tor port
	# FIXME-UPSTREAM(Krey): These options should be added to NixOS Module
	services.monero.extraConfig = toString [
    "prune-blockchain=1" # Use the pruned blockchain to save space
    "proxy=127.0.0.1:9050" # Use Tor Proxy to access the internet

    "public-node=0" # Whether to advertise the node to the wild (0=false)

    "no-igd=1" # Disable UPnP port mapping

    "tx-proxy=tor,127.0.0.1:9050,10"

    # FIXME-QA(Krey): This should be moved in a secret file and sourced, but it seems that monerod doesn't support file including and it's not problematic to have this public. -> Implement upstream and then move to secret to source
    "anonymous-inbound=yobndiqy7b5umy434mhvj2u7zttr2ro2nshybrmu3c354qqykqtc7pid.onion:18083,${config.services.monero.rpc.address}:18083,64"

    "out-peers=64" # This will enable much faster sync and tx awareness; the default 8 is suboptimal nowadays
    "in-peers=1024" # The default is unlimited; we prefer to put a cap on this
	];

	# Import the private key for an onion service
	age.secrets.mracek-onion-monero-private = {
		file = ../secrets/mracek-onion-monero-private.age;

		owner = "tor";
		group = "tor";

		path = "/var/lib/tor/onion/monero/hs_ed25519_secret_key";

		symlink = false; # Appears to not work as symlink
	};

	age.secrets.mracek-onion-monero-p2p-private = {
		file = ../secrets/mracek-onion-monero-p2p-private.age;

		owner = "tor";
		group = "tor";

		path = "/var/lib/tor/onion/monero-p2p/hs_ed25519_secret_key";

		symlink = false; # Appears to not work as symlink
	};

	# Deploy The Onion Service
	services.tor.relay.onionServices."monero".map = mkIf config.services.tor.enable [{ port = config.services.monero.rpc.port; target = { port = 18081; }; }]; # Set up Onionized Monero Node
	services.tor.relay.onionServices."monero-p2p".map = mkIf config.services.tor.enable [{ port = 18083; target = { port = 18083; }; }]; # Needed for p2p communications

	# Deploy NTP to manage a known threat, see https://github.com/monero-project/monero/blob/master/docs/ANONYMITY_NETWORKS.md#mitigation
	services.ntp.enable = true;
}
