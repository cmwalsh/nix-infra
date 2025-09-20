{ ... }:

{
  nfs.server = {
    enable = true;
    exports = ''
      /mnt/ironwolf/craig 192.168.3.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)
      /mnt/ironwolf/mary 192.168.3.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)
      /mnt/ironwolf/media 192.168.3.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)
    '';
  };
}
