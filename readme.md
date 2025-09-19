# Craig's NixOS Infrastructure flake

Greetings, this flake defines my homelab infrastructure. It is in constant flux and contains partially deployed configuration, use with caution. LLAP🖖

# Installation

```bash
# Clone the repo
git clone git@github.com:cmwalsh/nix-infra.git
cd nix-infra

# Format the disk with Disko
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest /
 -- --mode destroy,format,mount --flake .#<host>

# Generate a hardware configuration
sudo nixos-generate-config --no-filesystems --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix hosts/<host>/hardware.nix
git add .

# Install NixOS from the flake
sudo nixos-install --flake .#<host>

# Set the users password
cd /mnt
sudo nixos-enter
passwd <user>
exit

# Copy the flake to the users home directory
mv /home/nixos/nixos-infra /mnt/home/<user>
```
