{ config
, lib
, pkgs
, ...
}:
{
  options = {
    minecraft-module.enable = lib.mkEnableOption "Enables Minecraft";
  };

  config = lib.mkIf config.minecraft-module.enable {
    environment.systemPackages = [
      pkgs.prismlauncher
    ];
  };
}
