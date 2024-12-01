{pkgs, ...}: {
  # Based on https://github.com/JupiterBroadcasting/nixconfigs/blob/main/nextcloud.nix

  services = {
    nextcloud = {
      enable = true;
      hostname = "cloud.serenity.lan";
      package = pkgs.nextcloud30;
      database.createLocally = true;
      configureRedis = true;
      maxUploadSize = "16G";
      https = true;
      autoUpdateApps.enable = true;
    };

    settings = {
      overwriteProtocol = "https";
      default_phone_region = "GB";
    };

    config = {
      dbtype = "pgsql";
      adminuser = "admin";
      adminpassFile = "/REPLACE/WITH/YOUR/PATH";
    };

    # Suggested by Nextcloud's health check.
    phpOptions."opcache.interned_strings_buffer" = "16";
  };
}
