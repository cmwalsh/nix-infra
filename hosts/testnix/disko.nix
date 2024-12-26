{
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = "/dev/vda";
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
      vdb = {
        type = "disk";
        device = "/dev/vdb";
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
      vdc = {
        type = "disk";
        device = "/dev/vdc";
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
              members = ["vdb" "vdc"];
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
