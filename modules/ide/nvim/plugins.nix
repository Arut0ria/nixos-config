{
  treesitter = {
    enable = true;
    settings.indent.enable = true;
  };

  which-key = {
    enable = true;
  };

  conform-nvim = {
    enable = true;
    settings = {
      formater_by_ft = {
        nix = [ "nixfmt" ];
      };
    };
  };

  lualine = {
    enable = true;
  };

  nvim-autopairs = {
    enable = true;
  };

  cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };
  };

  # cmp-nvim-lsp.enable = true;
  # cmp-path.enable = true;
  # cmp-buffer.enable = true;
}
