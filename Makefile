.PHONY: switch

switch:
	echo "Initializing the system...."
	nix --extra-experimental-features "nix-command flakes" --show-trace build .#darwinConfigurations.morgana.system

	echo "Updating system..."
	./result/sw/bin/darwin-rebuild switch --flake ~/Repos/grimoire/.#morgana
