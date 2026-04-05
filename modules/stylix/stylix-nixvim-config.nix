{ config, lib, ... }:
let
  cfg = config.stylix-nixvim-config;
in
{
  options = {
    stylix-nixvim-config.enable = lib.mkEnableOption "Enables Stylix config for nixvim.";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      targets.nixvim = {
        enable = true;

        # plugin = "base16-nvim";
        # transparentBackground = {
        #   main = true;
        #   numberLine = true;
        #   signColumn = true;
        # };
      };
    };
  };
}
