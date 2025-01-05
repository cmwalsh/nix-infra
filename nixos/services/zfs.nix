{ ... }: {

  boot = {
    supportedFilesystems = [ "zfs" ];

    zfs = {
      forceImportRoot = false;
      forceImportAll = true;
      devNodes = "/dev/disk/by-id";
      extraPools = [ "ironwolf" ];
    };
  };

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };

  # Create and manage zpool.cache
  systemd.services.zfs-setup = {
    description = "Setup ZFS pools";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      mkdir -p /etc/zfs
      ${pkgs.zfs}/bin/zpool set cachefile=/etc/zfs/zpool.cache ironwolf
    '';
    wantedBy = [ "zfs.target" ];
  };
}
