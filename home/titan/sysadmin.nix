{ pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

  home = {
    username = "sysadmin";
    homeDirectory = "/home/sysadmin";

    packages = (
      with pkgs;
      [
        # Graphics
        vainfo
      ]
    );
  };
}
