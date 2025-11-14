{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    lanzaboote = {
#      url = "github:nix-community/lanzaboote/v0.4.2";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
   };

  outputs = { self, nixpkgs, home-manager, sops-nix, nvf, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop/configuration.nix
          sops-nix.nixosModules.sops

#          lanzaboote.nixosModules.lanzaboote
#          ({ pkgs, lib, ... }: {
#            environment.systemPackages = [
#              pkgs.sbctl
#            ];
#            boot.loader.systemd-boot.enable = lib.mkForce false;
#            boot.lanzaboote = {
#              enable = true;
#              pkiBundle = "/var/lib/sbctl";
#            };
#          })

          home-manager.nixosModules.home-manager
          {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mustlane = import ./home/users/mustlane.nix;
          }
      ];
    };
      nixosConfigurations.andiman = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/andiman/configuration.nix
#          sops-nix.nixosModules.sops
      ];
    };
  };
}
