{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hm.url = "github:nix-community/home-manager";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, hm, ... }@inputs:
  let
    lib = nixpkgs.lib;
    overlays = [ inputs.neovim.overlay ];

  in {
    nixosConfigurations = {
      thinkpad = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };

    hmConfigurations = {
      marvin = hm.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        username = "marvin";
        homeDirectory = "/home/marvin";
        configuration = {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = overlays;
          imports = [ ./home.nix ];
        };
      };
    };
  };
}

# {
#   description = "NixOS configuration";
#
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     home-manager.url = "github:nix-community/home-manager";
#   };
#
#   outputs = { nixpkgs, home-manager, ... }:
#   let
#     lib = nixpkgs.lib;
#
#   in {
#     nixosConfigurations = {
#       thinkpad = lib.nixosSystem {
#         system = "x86_64-linux";
#         modules = [
#           ./configuration.nix
#           home-manager.nixosModules.home-manager
#           {
#             home-manager.useGlobalPkgs = true;
#             home-manager.useUserPackages = true;
#             home-manager.users.marvin = import ./home.nix;
#           }
#         ];
#       };
#     };
#   };
# }

