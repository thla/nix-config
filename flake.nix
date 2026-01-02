{
  description = "Modular NixOS + Home Manager setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs"; # Forces HM to use your nixpkgs version
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations.nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/P52/configuration.nix

          # Home Manager as NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.thomas = import ./home/thomas.nix;
          }
        ];
      };
    };
}
