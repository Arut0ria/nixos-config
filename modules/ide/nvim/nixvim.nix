{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim-module;
  import_func =
    file:
    let
      imported = import file;
    in
    if builtins.isFunction imported then imported { inherit pkgs lib; } else imported;

  plugin-modules = map import_func (
    lib.filter (lib.strings.hasSuffix ".nix") (lib.filesystem.listFilesRecursive ./plugins)
  );
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

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      keymaps = import ./keymaps.nix;
      globalOpts = import ./options.nix;
      plugins = lib.mkMerge plugin-modules;

      vimAlias = true;
      viAlias = true;
      autoCmd = [
        {
          event = [
            "BufEnter"
            "BufWritePost"
            "InsertLeave"
          ];
          command = "lua require('lint').try_lint()";
          desc = "Try lint on write/insert/enter buffer.";
        }
        {
          event = [
            "VimEnter"
          ];
          command = "colorscheme catppuccin-mocha";
          desc = "Set catppuccin-mocha as default theme";
        }
      ];

      diagnostic.settings = {
        virtual_text = {
          spacing = 4;
          prefix = "►";
        };

        virtual_lines = {
          current_line = true;
        };

        signs = {
          text.__raw = ''
            {[vim.diagnostic.severity.ERROR] = '󰅚',
            [vim.diagnostic.severity.WARN] = '󰀪',
            [vim.diagnostic.severity.HINT] = '󰌶',
            [vim.diagnostic.severity.INFO] = '󰋽' }
          '';
        };
        underline = true;
        update_in_insert = false;
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          transparent_background = true;
          integrations = {
            treesitter = true;
            native_lsp.enabled = true;
            telescope.enabled = true;
            indent_blankline.enabled = true;
          };
        };
      };

      extraPackages = with pkgs; [
        eslint_d
        tree-sitter
        ripgrep
      ];
    };
  };
}
