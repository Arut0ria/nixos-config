{ inputs, moduleWithSystem, ... }:
{
  flake.nixosModules.devenv = moduleWithSystem (
    perSystem@{ system, ... }:
    nixos@{
      pkgs,
      # config,
      # lib,
      ...
    }:
    let
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      config = {
        nixpkgs.overlays = [
          (final: prev: {
            devenv = pkgs-unstable.devenv;
          })
        ];

        environment.systemPackages = with pkgs; [
          devenv
          direnv
        ];
      };
    }
  );
}
