{ pkgs, ... }:

{

  services.jellyfin = {
    enable = true;
    user = "media";
    openFirewall = true;
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
