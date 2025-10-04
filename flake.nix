{
  description = "Infrastructure defined as Nix";

  inputs = {
    # Nix packages
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nixos hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Disko
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    # Sops Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Quadlet Nix
    quadlet-nix.url = "github:SEIAROTg/quadlet-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:

    let
      # Configure unstable packages
      pkgs-unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";

        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    in

    {
      nixosConfigurations = {
        # Framework 13 laptop
        defiant = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/defiant
          ];

          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };
        };

        # Lenovo Thinkpad T495 laptop
        equinox = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/equinox
          ];

          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };
        };

        # Dell Optiplex 3040 server
        raven = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/raven
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        # 5800X NAS
        titan = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/titan
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        # HP MicroServer Gen 8
        cube = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/cube
          ];

          specialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
