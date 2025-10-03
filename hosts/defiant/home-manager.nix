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
      craig = import ../../home/defiant/craig.nix;
    };

    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs-unstable;
    };
  };
}
