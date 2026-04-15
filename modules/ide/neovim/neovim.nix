{ inputs, self, ... }:
{
  flake.modules.neovim =
    {
      config,
      lib,
      wlib,
      pkgs,
      ...
    }:
    {
      options = {
        impure = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Use impure config for quick testing.";
        };
      };

      config = {
        extraPackages = with pkgs; [
          ripgrep
          nixd
          nixfmt
          lua-language-server
          stylua
          tree-sitter
          lazygit

          self.packages.${pkgs.stdenv.hostPlatform.system}.ressources
        ];

        env =
          let
            res = self.packages.${pkgs.stdenv.hostPlatform.system}.ressources;
          in
          {
            HEADER_PATH = "${res}/share/header.ansi";
          };

        # specs.snacks = {
        #   before = [ "INIT_MAIN" ];
        #   data = with pkgs.vimPlugins; [
        #     snacks-nvim
        #   ];
        # };

        specs.plugins = {
          data = with pkgs.vimPlugins; [
            blink-cmp
            oil-nvim
            lualine-nvim
            nvim-web-devicons
            snacks-nvim
            which-key-nvim
            indent-blankline-nvim
            nvim-treesitter.withAllGrammars
            nvim-lint
            conform-nvim
            gitsigns-nvim
            lazygit-nvim
            mini-pairs
            nvim-lspconfig
            telescope-nvim

            catppuccin-nvim
          ];
        };

        settings = {
          config_directory = lib.mkDefault ./.;
          aliases = [
            "vi"
            "vim"
          ];
        };
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.neovim = inputs.nix-wrappers-modules.wrappers.neovim.wrap {
        inherit pkgs;
        imports = [ self.modules.neovim ];
      };
    };
}
