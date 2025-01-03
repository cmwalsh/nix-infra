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
        mode = {
          topology = {
            type = "topology";
            vdev = [{
              mode = "mirror";
              members = ["sda" "sdb"];
            }];
          };
        };
        mountpoint = "/mnt/ironwolf";
        datasets = {
          craig = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/craig";
          };
          mary = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/mary";
          };
          media = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/media";
          };
          appdata = {
            type = "zfs_fs";
            mountpoint = "/mnt/ironwolf/appdata";
          };
        };
      };
    };
  };
}
