{ config, lib, ... }:
let
  cfg = config.neovim-module;
in
{
  options = {
    neovim-module = {
      enable = lib.mkEnableOption "Enables nixvim config.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      globalOpts = import ./options.nix;
      plugins = (import ./plugins.nix) // {
        lsp = {
          enable = true;
          servers = {
            nixd = {
              enable = true;
            };
          };
        };
      };

      vimAlias = true;
    };
  };
}
