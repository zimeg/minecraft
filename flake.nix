{
  description = "a chest of redstone or something";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            papermcServers.papermc-1_21
          ];
        };
        devShells.backup = pkgs.mkShell {
          packages = with pkgs; [
            awscli2
            opentofu
          ];
        };
      });
}
