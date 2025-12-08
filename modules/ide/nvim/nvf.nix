{
  lib,
  config,
  ...
}: let
  cfg = config.neovim-module;
in {
  options = {
    neovim-module = {
      enable = lib.mkEnableOption "Enable nvf config module";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = false;
          vimAlias = true;
          lsp = {
            enable = true;
            formatOnSave = true;
          };

          autopairs.nvim-autopairs.enable = true;

          filetree = {
            neo-tree.enable = true;
          };

          visuals = {
            indent-blankline.enable = true;
          };

          languages = {
            enableFormat = true;
            enableTreesitter = true;

            clang.enable = true;
            nix.enable = true;
            ts.enable = true;
            python.enable = true;
          };

          autocomplete = {
            nvim-cmp = {enable = true;};
          };

          git = {
            enable = true;
          };

          formatter = {
            conform-nvim = {
              enable = true;
              setupOpts = {
                formater_by_ft = {
                  nix = ["nixfmt"];
                };
              };
            };
          };

          statusline.lualine.enable = true;
        };
      };
    };
  };
}
