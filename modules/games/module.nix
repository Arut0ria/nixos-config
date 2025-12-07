{ lib, ... }:
let
  NixosBaseModules = {
    emulation-module = {
      imports = [
        ./emulation.nix
      ];

      config.emulation-module = {
        enable = lib.mkDefault true;
        retroarch.enable = lib.mkDefault true;
        pcsx2.enable = lib.mkDefault true;
        rpcs3.enable = lib.mkDefault true;
        ryubing.enable = lib.mkDefault true;
      };
    };

    minecraft-module = {
      imports = [
        ./minecraft.nix
      ];

      config.minecraft-module.enable = lib.mkDefault true;
    };

    gaming-packages-module = {
      imports = [
        ./packages.nix
      ];

      config.gaming-packages-module = {
        enable = lib.mkDefault true;
        protonup.enable = lib.mkDefault true;
        bottles.enable = lib.mkDefault true;
        heroic.enable = lib.mkDefault true;
      };
    };

    launchers-module = {
      imports = [
        ./launchers.nix
      ];

      config.launchers-module.enable = lib.mkDefault true;
    };
  };

  HomeBaseModules = {
    mangohud-module = {
      imports = [
        ./mangohud.nix
      ];

      config.mangohud-module.enable = lib.mkDefault true;
    };
  };
in
{
  nixosModules = NixosBaseModules // {
    games-module = {
      imports = builtins.attrValues NixosBaseModules;
    };
  };

  homeModules = HomeBaseModules // {
    games-module = {
      imports = builtins.attrValues HomeBaseModules;
    };
  };
}
