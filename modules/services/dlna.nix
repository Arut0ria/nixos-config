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
    };
  };

  config = lib.mkIf config.dlna-module.enable {
    services.minidlna.enable = true;
    services.minidlna.settings = {
      friendly_name = cfg.settings.name;
      media_dir = cfg.settings.mediaDir;
      log_level = "error";
      inotify = "yes";
      wide_links = "yes";
    };

    users.users.minidlna = {
      # isNormalUser = false;
      extraGroups = [ "users" ]; # so minidlna can access the files.
    };
  };
}
