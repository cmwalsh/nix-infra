{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              name = "ESP";
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["defaults"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-L" "nixos" "-f"];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = ["subvol=root" "compress=zstd" "noatime"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["subvol=home" "compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
      nvme1n1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            nextcloud = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                mountpoint = "/mnt/nextcloud";
                mountOptions = [ "compress=zstd" "noatime" ];
              };
            };
          };
        };
      };
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "ironwolf";
              };
            };
          };
        };
      };
      sdb = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "ironwolf";
              };
            };
          };
        };
      };
    };
    zpool = {
      ironwolf = {
        type = "zpool";
        rootFsOptions = {
          compression = "lz4";
          acltype = "posixacl";
          xattr = "sa";
          atime = "off";
        };
        mode = {
          topology = {
            type = "topology";
            vdev = [{
              mode = "mirror";
              members = ["sda" "sdb"];
            }];
          };
        };
        datasets = {
          craig = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/craig";
            options = {
              compression = "lz4";
              mountpoint = "legacy";
            };
          };
          mary = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/mary";
            options = {
              compression = "lz4";
              mountpoint = "legacy";
            };
          };
          media = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/media";
            options = {
              compression = "lz4";
              mountpoint = "legacy";
            };
          };
          appdata = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/appdata";
            options = {
              compression = "lz4";
              mountpoint = "legacy";
            };
          };
        };
      };
    };
  };

  # Mount the ZFS datasets
  fileSystems."/mnt/ironwolf/craig" = {
    device = "ironwolf/craig";
    fsType = "zfs";
    options = [ "zfsutil" ];
    neededForBoot = true;
  };

  fileSystems."/mnt/ironwolf/mary" = {
    device = "ironwolf/mary";
    fsType = "zfs";
    options = [ "zfsutil" ];
    neededForBoot = true;
  };

  fileSystems."/mnt/ironwolf/media" = {
    device = "ironwolf/media";
    fsType = "zfs";
    options = [ "zfsutil" ];
    neededForBoot = true;
  };

  fileSystems."/mnt/ironwolf/appdata" = {
    device = "ironwolf/appdata";
    fsType = "zfs";
    options = [ "zfsutil" ];
    neededForBoot = true;
  };
}
