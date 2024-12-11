# Installation

1. Boot into a live enviroment and clone the flake

```bash
git clone https://github.com/cmwalsh/nix-infra.git
```

2. Run the disko partitionioning script

```bash
sudo nix \
    --experimental-features "nix-command flakes" \
    run github:nix-community/disko -- --mode disko \
    nix-infra/nixos/host/disko-config.nix
```

3. Generate an initiial NixOS configuration

```bash
sudo nixos-generate-config --no-filesystems --root /mnt
```

4. Copy the `hardware-configuration.nix` file to the flake

```bash
sudo cp /etc/nixos/hardware-configuration.nix nix-infra/nixos/host/
```

5. Install NixOS, set a root password and reboot

```bash
cd nix-infra
sudo nixos-install --root /mnt --flake .#host
```

6. Log in as root and set user passwords
7. Log in as user and generate SSH keys
8. Add SSH key to Github and clone the flake (using SSH)
9. Re-copy the `hardware-configuration.nix` file and commit changes
