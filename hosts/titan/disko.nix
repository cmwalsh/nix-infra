{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              name = "root-part";
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
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
            appdata = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/mnt/appdata";
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

      sdc = {
        type = "disk";
        device = "/dev/sdc";
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

      sdd = {
        type = "disk";
        device = "/dev/sdd";
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
      rpool = {
        type = "zpool";

        options = {
          ashift = "12";
          autotrim = "on";
        };

        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
          dnodesize = "auto";
          normalization = "formD";
        };

        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options = {
              mountpoint = "legacy";
              canmount = "noauto";
            };
          };

          "nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              atime = "off";
            };
          };

          "home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options = {
              atime = "on";
            };
          };

          "var_log" = {
            type = "zfs_fs";
            mountpoint = "/var/log";
          };

          "tmp" = {
            type = "zfs_fs";
            mountpoint = "/tmp";
            options = {
              sync = "disabled";
              acltype = "posixacl";
            };
          };
        };
      };

      ironwolf = {
        type = "zpool";

        mode = {
          topology = {
            type = "topology";
            vdev = [
              {
                mode = "raidz1";
                members = [
                  "sda"
                  "sdb"
                  "sdc"
                  "sdd"
                ];
              }
            ];
          };
        };

        options = {
          ashift = "12";
          autotrim = "on";
        };

        rootFsOptions = {
          compression = "zstd";
          atime = "off";
          xattr = "sa";
          acltype = "posixacl";
          dnodesize = "auto";
          normalization = "formD";
          canmount = "on";
        };

        datasets = {
          "craig" = {
            type = "zfs_fs";
            options = {
              compression = "lz4";
              canmount = "on";
              mountpoint = "/mnt/ironwolf/craig";
            };
          };

          "mary" = {
            type = "zfs_fs";
            options = {
              compression = "lz4";
              canmount = "on";
              mountpoint = "/mnt/ironwolf/mary";
            };
          };

          "media" = {
            type = "zfs_fs";
            options = {
              compression = "lz4";
              canmount = "on";
              mountpoint = "/mnt/ironwolf/media";
            };
          };
        };
      };
    };
  };
}
