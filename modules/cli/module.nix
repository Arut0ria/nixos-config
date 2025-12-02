{ lib, ... }:
let
  baseModules = {
    fastfetch-module = {
      imports = [
        ./fastfetch.nix
      ];

      config.fastfetch-module.enable = lib.mkDefault true;
    };

    cava-module = {
      imports = [
        ./cava.nix
      ];

      config.cava-module.enable = lib.mkDefault true;
    };

    ranger-module = {
      imports = [
        ./ranger.nix
      ];

      config.ranger-module.enable = lib.mkDefault true;
    };

    btop-module = {
      imports = [
        ./btop.nix
      ];

      config.btop-module.enable = lib.mkDefault true;
    };
  };

  cli-module.imports = builtins.attrValues baseModules;
in
{
  homeModules = baseModules // {
    inherit cli-module;
  };
}
