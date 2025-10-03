{ inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users = {
      sysadmin = import ../../home/cube/sysadmin.nix;
    };

    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs-unstable;
    };
  };
}
