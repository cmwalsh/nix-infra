# Server configuration flake

This flake defines the configuration for the Serenity Homelab.

# Installation

`sudo nix-shell -p git`
`git clone https://github.com/cmwalsh/nix-infra.git`
`sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount hosts/<host>/disko.nix`
`nixos-generate-config --no-filesystems --root /mnt`
`cp /mnt/etc/nixos/hardware-configuration.nix hosts/<host>/`
`git add .`
`nixos-install --flake .#<host>`

# Add host to secrets

`cat /home/<host>/.ssh/id_ed25519.pub | ssh-to-age`
`sops updatekeys secrets/secrets.yaml`
