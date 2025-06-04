{ ... }: {

  # Operating system drive
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/<uuid>";
    fsType = "btrfs";
  };

  # Use mergerfs to merge all data drives to /data
  filesystems."/data" = {
    fsType = "fuse.mergerfs";
    device = "/mnt/data";

    options = [
      "cache.files=partial"
      "dropcacheonclose=true"
      "category.create=mfs"
      "func.getattr=newest"
    ];
  };

  # Parity drive for snapraid
  filesystems."/mnt/parity1" = {
    device = "/dev/disk/by-label/<label>";
    fsType = "xfs";
  };

  # Data drives used by mergerfs
  filesystems."/mnt/data1" = {
    device = "/dev/disk/by-label/<label>";
    fsType = "xfs";
  };

  filesystems."/mnt/data2" = {
    device = "/dev/disk/by-label/<label>";
    fsType = "xfs";
  };

  filesystems."/mnt/data3" = {
    device = "/dev/disk/by-label/<label>";
    fsType = "xfs";
  };

  filesystems."/mnt/data4" = {
    device = "/dev/disk/by-label/<label>";
    fsType = "xfs";
  };

  snapraid = {
    enable = true;

    parityFiles = [
      "/mnt/parity1/snapraid.parity"
    ];

    dataDisks = {
      d1 = "/mnt/data1/";
      d2 = "/mnt/data2/";
      d3 = "/mnt/data3/";
      d4 = "/mnt/data4/";
    };

    # The content files can be placed wherever. There just needs
    # to be (number of parity drives + 1) content files.
    contentFiles = [
      "/mnt/data3/snapraid.content"
      "/mnt/data4/snapraid.content"
    ];
  };
}
