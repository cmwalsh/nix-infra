# Install NixOS

1. Boot into a live environment and clone this flake

```sh
git clone https://github.com/cmwalsh/nix-infra.git /tmp
```

2. Run the partitioning script:

Update `nixos/host/disk-config.nix` with the id of the disk to be formatted.

```sh
sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko /tmp/nix-infra/nixos/host/disko-config.nix
```

3. Generate the initial Nix Config

```sh
sudo nixos-generate-config --no-filesystems --root /mnt
```

4. Copy the generated hardware-configuration to the flake

```sh
sudo cp /etc/nixos/hardware-configuration.nix /tmp/nix-infra/nixos/host/
```

5. Install NixOS

```sh
sudo nixos-install --root /mnt --flake '/tmp/nix-infra#host'
```

# After installation

1. Clone the flake again to a convenient location
2. Copy the hardware configuration from /etc/nixos/hardware-configuration.nix
3. Generate a hostId with `head -c 8 /etc/machine-id` and add to network configuration
4. Run `home-manager switch --flake .` and reboot
