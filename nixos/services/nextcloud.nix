{config, pkgs, ...}: {
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
      adminpassFile = config.sops.nc_admin_pw.path;
    };

    # Suggested by Nextcloud's health check.
    phpOptions."opcache.interned_strings_buffer" = "16";
  };

  sops.secrets.nc_admin_pw.owner = config.users.sysadmin.name;
}
