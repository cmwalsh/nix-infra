{ pkgs, ... }:

{
  imports = [
    ../common.nix
    ../containers/smokeping.nix
  ];

  home = {
    username = "sysadmin";
    homeDirectory = "/home/sysadmin";

    packages = (
      with pkgs;
      [
        # Graphics
        intel-gpu-tools
      ]
    );
  };
}
