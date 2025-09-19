{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "table";
          format = "msdos";
          partitions = {
            boot = {
              size = "1M";
              type = "bios_grub";
            };

            ESP = {
              size = "1G";
              type = "primary";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/boot";
                label = "nixos-boot";
              };
            };

            root = {
              name = "root-part";
              size = "100%";
              type = "primary";
              content = {
                type = "zfs";
                pool = "rpool";
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
              name = "data1";
              size = "100%";
              content = {
                type = "zfs";
                pool = "backup";
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
              name = "data2";
              size = "100%";
              content = {
                type = "zfs";
                pool = "backup";
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
              name = "data3";
              size = "100%";
              content = {
                type = "zfs";
                pool = "backup";
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

      backup = {
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
          "backup" = {
            type = "zfs_fs";
            mountpoint = "/backup";
            options = {
              mountpoint = "legacy";
              canmount = "noauto";
            };
          };

          "titan" = {
            type = "zfs_fs";
            mountpoint = "/backup/titan";
            options = {
              atime = "off";
            };
          };
        };
      };
    };
  };
}
