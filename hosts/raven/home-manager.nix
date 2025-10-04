{ inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.quadlet-nix.nixosModules.quadlet
    inputs.home-manager.nixosModules.home-manager
  ];

  # Enable the Quadlet systemd generator
  virtualisation.quadlet.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users = {
      sysadmin = import ../../home/raven/sysadmin.nix;
    };

    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs-unstable;
    };
  };
}
