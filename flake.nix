{
  description = "Onyx OSV - Belial dev flake (no behavior change)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        belial = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/belial/configuration.nix
          ];
        };
      };
    };
}
