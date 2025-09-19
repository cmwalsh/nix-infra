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
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
              attributes = [ 0 ];
            };

            root = {
              name = "root";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
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
