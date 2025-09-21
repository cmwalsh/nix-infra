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

  # https://wiki.nixos.org/wiki/Jellyfin#Troubleshooting_VAAPI_and_Intel_QSV
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD";
}
