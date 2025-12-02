{ lib, ... }:
let
  baseModules = {
    kitty-module = {
      imports = [
        ./kitty.nix
      ];

      config.kitty-module.enable = lib.mkDefault true;
    };

    zsh-module = {
      imports = [
        ./zsh.nix
      ];

      config.zsh-module.enable = lib.mkDefault true;
    };
  };

  shell-module.imports = builtins.attrValues baseModules;
in
{
  homeModules = baseModules // {
    inherit shell-module;
  };
}
