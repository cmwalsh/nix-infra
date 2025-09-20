{ pkgs, ... }:

{
  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "SERENITY";
        "server string" = "titan";
        "netbios name" = "titan";
        "security" = "user";
        "guest ok" = "yes";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "load printers" = "no";
      };

      media = {
        "path" = "/mnt/ironwolf/media";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "media";
        "force group" = "users";
      };

      craig = {
        "path" = "/mnt/ironwolf/craig";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "craig";
        "force group" = "users";
      };

      mary = {
        "path" = "/mnt/ironwolf/mary";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "mary";
        "force group" = "users";
      };
    };
  };

  # Enable autodiscovery on Windows
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
