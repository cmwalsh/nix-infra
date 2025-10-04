{ pkgs, ... }:

{
  imports = [
    ../common.nix
    ../containers/mealie.nix
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
