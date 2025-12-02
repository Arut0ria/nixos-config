{ config, lib, pkgs, ... }:
let
  cfg = config.gaming-packages-module;
in
{
  options = {
    gaming-packages-module = {
      enable = lib.mkEnableOption "Enables gaming system pacakges (protonup, bottles, heroic, ...).";
      protonup.enable = lib.mkEnableOption "Enables protonup package.";
      bottles.enable = lib.mkEnableOption "Enables bottles package.";
      heroic.enable = lib.mkEnableOption "Enables Heroic package.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.mkMerge (with pkgs; [
      (lib.optionals cfg.protonup.enable [ protonup-ng ])
      (lib.optionals cfg.bottles.enable [ bottles ])
      (lib.optionals cfg.heroic.enable [ heroic ])
    ]);
  };
}
