{ config, lib, ... }:
{
  nixosModules = {
    fr-locale-module = {
      imports = [
        ./locales/french-locale.nix
      ];

      config.fr-locale-module.enable = lib.mkDefault true;
    };

    nvidia-module = {
      imports = [
        ./nvidia.nix
      ];

      config.nvidia-module.enable = lib.mkDefault true;
    };

    caching-module = {
      imports = [
        ./caching-module.nix
      ];

      config.caching-module.enable = lib.mkDefault true;
    };
  };
}
