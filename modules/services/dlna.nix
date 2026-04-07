{ config, lib, ... }:
let
  cfg = config.dlna-module;
in
{
  options = {
    dlna-module.enable = lib.mkEnableOption "Enables mini-dlna service.";
    dlna-module.settings = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "DLNA MEDIA";
        description = "Name visible on network for mini-dlna server.";
      };

      mediaDir = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "PVA,/dlna"
        ];
        description = "List of directory visible by mini-dlna service (see doc).";
      };

      networkInterface = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "The interface to listen to.";
      };

      port = lib.mkOption {
        type = lib.types.int;
        default = 8200;
        description = "The port to listen to";
      };
    };
  };

  config = lib.mkIf config.dlna-module.enable {
    services.minidlna = {
      enable = true;
      settings = {
        friendly_name = cfg.settings.name;
        media_dir = cfg.settings.mediaDir;
        log_level = "warning";
        inotify = "yes";
        wide_links = "yes";
        network_interface = lib.optional (
          cfg.settings.networkInterface != null
        ) cfg.settings.networkInterface;
        port = cfg.settings.port;
      };

      # Should open 8200 and 1900 (UPnP)
      openFirewall = true;
    };

    users.users.minidlna = {
      # isNormalUser = false;
      extraGroups = [ "users" ]; # so minidlna can access the files.
    };
  };
}
