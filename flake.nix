{
  description = "a chest of redstone or something";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          awscli2
          opentofu
        ];
        shellHook = ''
          export MINECRAFT_AWS_ACCESS_KEY=$(tofu -chdir=backup output -raw minecraft_access_key)
          export MINECRAFT_AWS_SECRET_ACCESS_KEY=$(tofu -chdir=backup output -raw minecraft_secret_access_key)
        '';
      };
    };
}
