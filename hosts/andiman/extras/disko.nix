{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "4GB";
              content = {
                type = "swap";
                resumeDevice = true;
                priority = 1;
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                mountpoint = "/";
                };
                subvolumes = {
                  "/root" = {};
                  "/home/andrei" = {};
                };
              };
            };
          };
        };
      };
      hdd = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            sdb1 = {
              size = "100%";
              name = "sdb1"
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
              };
            };
          };
        };
      };
    };
  };
}
