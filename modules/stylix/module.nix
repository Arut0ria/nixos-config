{ lib, ... }:
let
  baseModules = {
    stylix-plasma-config = {
      imports = [
        ./stylix.nix
        ./stylix-nixvim-config.nix
        ./stylix-plasma-config.nix
      ];

      config.stylix-module.enable = lib.mkDefault true;
      config.stylix-nixvim-config.enable = lib.mkDefault true;
      config.stylix-plasma-config.enable = lib.mkDefault true;
    };
  };
in
{
  nixosModules = baseModules;
}
