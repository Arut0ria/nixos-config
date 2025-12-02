{ config, lib, ... }: {
  nixosModules.plasma-module = {
    imports = [
      ./plasma/plasma.nix
    ];

    config.plasma-module.enable = lib.mkDefault true;
  };

  homeModules.plasma-manager-config = {
    imports = [
      ./plasma/plasma-manager.nix
    ];
    config.plasma-manager-config.enable = lib.mkDefault true;
  };
}
