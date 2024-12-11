{ ... }: {

  boot.zfs = {
    # Ensure a serial number is added
    # to any virtual storage if using a VM
    # Use uuidgen command
    devNodes = "/dev/disk/by-id";
    forceImportAll = true;
  };

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
}
