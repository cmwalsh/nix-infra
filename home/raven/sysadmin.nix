{ ... }:

{
  imports = [
    ../common.nix
    ../containers/dashy.nix
  ];

  home = {
    username = "sysadmin";
    homeDirectory = "/home/sysadmin";
  };
}
