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

    # Sops Nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    # Configure stable packages
    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    # Configure unstable packages
    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  
  in {
    nixosConfigurations = {
      # Gaming desktop
      "jarvis" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        modules = [
          ./hosts/jarvis
          ./profiles/desktop.nix
        ];
      };

      # Framework laptop
      "defiant" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        modules = [
          ./hosts/defiant
          ./profiles/laptop.nix
        ];
      };

      # Rocinante server
      "rocinante" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        modules = [
          ./hosts/rocinante
          ./profiles/server.nix
        ];
      };
    };

    homeConfigurations = {
      # User craig
      "craig" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
        };

        modules = [
          ./home-manager/craig
        ];
      };

      # User sysadmin
      "sysadmin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
        };

        modules = [
          ./home-manager/sysadmin
        ];
      };
    };
  };
}
