{ config, lib, pkgs, ... }:
let
  cfg = config.gaming-packages-module;
  inherit (config) me;
in
{
  options = {
    gaming-packages-module = {
      enable = lib.mkEnableOption "Enables gaming system pacakges (protonup, bottles, heroic, ...).";
      protonup.enable = lib.mkEnableOption "Enables protonup package.";
      bottles.enable = lib.mkEnableOption "Enables bottles package.";
      heroic.enable = lib.mkEnableOption "Enables Heroic package.";
      gamemode.enable = lib.mkEnableOption "Enables feral gamemode.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.mkMerge (with pkgs; [
      (lib.optionals cfg.protonup.enable [ protonup-ng ])
      (lib.optionals cfg.bottles.enable [ bottles ])
      (lib.optionals cfg.heroic.enable [ heroic ])
    ]);

    programs.gamemode = lib.mkIf cfg.gamemode.enable {
      enable = true;
      enableRenice = true;
      
      settings = {
        general =  {
          softrealtime = "auto";
          renice = 10;         
        };
      };
    };

    # Adding user to gamemode group if necessary
    users.groups.gamemode.members = lib.mkIf cfg.gamemode.enable [ me.username ];
  };
}
