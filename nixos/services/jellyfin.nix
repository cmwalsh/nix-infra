{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  services.jellyfin = {
    enable = true;
    user = "media";
    group = "serenity";
    openFirewall = true;
  };
}
