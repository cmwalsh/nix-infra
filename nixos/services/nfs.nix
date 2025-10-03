{ ... }:

{
  nfs.server = {
    enable = true;
    exports = ''
      /mnt/ironwolf/craig/ISOs 192.168.3.0/24(rw,sync,no_subtree_check,crossmnt,fsid=0)
    '';
  };
}
