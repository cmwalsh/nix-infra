# Craig's Nix Config

This is the flake that defines my homelab. All workstations and servers run NixOS and the configuration is in constant flux. Use with caution. LLAP 🖖

## Installation

1. Clone the git repository.

```bash
git clone git@github.com:cmwalsh/nix-infra.git
cd nix-infra
```

2. Run the Disko script to partition and mount drives.

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest /
 -- --mode destroy,format,mount hosts/<host>/disks.nix
```

2. If this is the first installation on this host, generate a hardware configuration and copy it to the flake.

```bash
sudo nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix hosts/<host>/hardware.nix
git add .
```

3. Install NixOS from the flake

```bash
sudo nixos-install --flake .#<host>
```

4. Chroot into the install and reset user password. 

```bash
cd /mnt 
sudo nixos-enter
passwd craig
exit
```

5. Copy the flake to the users home directory.

```bash
mv /home/nixos/nixos-infra /mnt/home/craig/
```
