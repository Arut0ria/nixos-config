{ config, lib, ... }: {
  options = {
    discord-module.enable = lib.mkEnableOption "Enables vesktop (discord).";
  };

  config = lib.mkIf config.discord-module.enable {
    programs.vesktop.enable = true;
  };
}
