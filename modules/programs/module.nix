{ lib, ... }:
let
  baseModules = {
    firefox-module = {
      imports = [
        ./firefox.nix
      ];

      config.firefox-module.enable = lib.mkDefault true;
    };

    discord-module = {
      imports = [
        ./discord.nix
      ];

      config.discord-module.enable = lib.mkDefault true;
    };
  };

  programs-module.imports = builtins.attrValues baseModules;
in
{
  homeModules = baseModules // {
    inherit programs-module;
  };
}
