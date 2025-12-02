{ lib, ... }:
let
  baseModules = {
    stylix-plasma-config = {
      imports = [
        ./stylix-plasma-config.nix
      ];

      config.stylix-plasma-config.enable = lib.mkDefault true;
    };
  };
in
{
  nixosModules = baseModules;
}
