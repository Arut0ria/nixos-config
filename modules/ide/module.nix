{ lib, ... }:
let
  baseModules = {
    vscode-module = {
      imports = [
        ./vscode.nix
      ];

      config.vscode-module.enable = lib.mkDefault true;
    };

    neovim-module = {
      imports = [
        ./nvim/nixvim.nix
      ];

      config.neovim-module.enable = lib.mkDefault true;
    };
  };

  ide-module.imports = builtins.attrValues baseModules;
in
{
  homeModules = baseModules // {
    inherit ide-module;
  };
}
