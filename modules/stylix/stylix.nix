{ config, lib, ... }:
let
  cfg = config.stylix-module;
in
{
  options = {
    stylix-module.enable = lib.mkEnableOption "Enables stylix.";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = true;
    };
  };
}
