{ ... }:

{
  services = {
    udev.extraRules = ''
      # EVO80
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36b0", ATTRS{idProduct}=="300e", MODE="0660", GROUP="input", TAG+="uaccess", TAG+="udev-acl", , SYMLINK+="evo80"
    '';
  };
}
