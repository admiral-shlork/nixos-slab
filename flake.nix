{
  description = "whatever Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    brlaser_nixpkgs.url = "github:ahydronous/nixpkgs/e4b52e42c6f6ededdf64a412393fc3d6bd681555";
    veracrypt_nixpkgs.url = "github:NixOS/nixpkgs?rev=50165c4f7eb48ce82bd063e1fb8047a0f515f8ce";

    # use the following for unstable:
    # nixpkgs.url = "nixpkgs/nixos-unstable";

    # or any branch you want:
    # nixpkgs.url = "nixpkgs/{BRANCH-NAME}";
  };

  outputs = { self, nixpkgs, home-manager, brlaser_nixpkgs, veracrypt_nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        slab = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                users.whatever = import ./home.nix;
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
            { 
              _module.args = {
                inherit brlaser_nixpkgs veracrypt_nixpkgs;
              };
            }

          ];
        };
      };
  };
}
