{ ... }: {

  boot.zfs = {
    devNodes = "/dev/disk/by-partuuid";
    forceImportAll = true;
  };

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
