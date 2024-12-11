{ ... }: {

  boot.zfs = {
    devNodes = "/dev/disk/by-id/";
    forceImportAll = true;
  };

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
