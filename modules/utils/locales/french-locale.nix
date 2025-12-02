{ lib, config, ... }:
{
  options = rec {
    fr-locale-module.enable = lib.mkEnableOption "Enables french locale";
  };

  config = lib.mkIf config.fr-locale-module.enable {
    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";

    console = {
      font = "Lat2-Terminus16";
      keyMap = "fr";
    };

    services = {
      xserver = {
        xkb.layout = "fr";
        xkb.options = "eurosign:e,caps,escape";
      };
    };
  };
}
