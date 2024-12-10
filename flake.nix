{
  description = "Serenity Infrastrucure Flake";

  inputs = {
    # Nix packages
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
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

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    # Supported systems
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

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
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      # Defiant (Framework laptop)
      defiant = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          username = "craig";
        };

        modules = [
          ./hosts/defiant
          ./nixos/common
        ];
      };

      # Carbon (Lenovo laptop)
      carbon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
        };

        modules = [
          ./hosts/carbon
          ./nixos/common
        ];
      };

      # Firefly (Server - NAS)
      firefly = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          username = "sysadmin";
        };

        modules = [
          ./hosts/firefly
          ./nixos/common
        ];
      };

      # Rocinante (Server - NOC)
      rocinante = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          username = "sysadmin";
        };

        modules = [
          ./hosts/rocinante
          ./nixos/common
        ];
      };

      # TestNix (Server - Test)
      testnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          inherit pkgs-unstable;
          username = "sysadmin";
        };

        modules = [
          ./hosts/testnix
          ./nixos/common
        ];
      };
    };

    homeConfigurations = {
      # User Craig
      "craig" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
        };

        modules = [
          ./home/craig
        ];
      };
    };
  };
}
