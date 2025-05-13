{ config, lib, pkgs, ... }: {

  # Mount the disks to be pooled by MergerFS
  fileSystems."/mnt/disks/disk01" = {
    device = "/dev/disk/by-label/disk01";
    fsType = "xfs";
  };

  fileSystems."/mnt/disks/disk02" = {
    device = "/dev/disk/by-label/disk02";
    fsType = "xfs";
  };

  # MergerFS pool
  fileSystems."/mnt/data" = {
    depends = [
      "/mnt/disks/data01"
      "/mnt/disks/data02"
    ];

    device = "/mnt/disks/disk*";
    fsType = "mergerfs";
    options = ["defaults" "minfreespace=250G" "fsname=mergerfs-jbod"];
  };

  # Mount disk to used for parity
  fileSystems."/mnt/disks/parity01" = {
    depends = [
      "/mnt/data"
    ];

    device = "/dev/disk/by-label/parity01";
    fsType = "xfs";
  };

  # SnapRAID
  services.snapraid = {
    enable = true;
  };
}
