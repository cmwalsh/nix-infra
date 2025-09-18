{ lib, ... }:

{
  services.technitium-dns-server = {
    enable = true;
    openFirewall = true;
  };

  # Technitium can't access /var/lib/technitium-dns-server
  # https://github.com/NixOS/nixpkgs/issues/416320#issuecomment-2986237772
  # Fixed in 25.11
  systemd.services.technitium-dns-server.serviceConfig = {
    WorkingDirectory = lib.mkForce null;
    BindPaths = lib.mkForce null;
  };
}
