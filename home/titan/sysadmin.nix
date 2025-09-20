{ ... }:

{
  imports = [
    ../common.nix
  ];

  home = {
    username = "sysadmin";
    homeDirectory = "/home/sysadmin";
  };
}
