{ ... }:
{
  flake.nixosModules.dlna =
    { config, lib, ... }:
    {
      options = {
        dlna-network-interface = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "The interface to listen to.";
        };
      };

      config = {
        services.minidlna = {
          enable = lib.mkDefault true;
          settings = {
            friendly_name = lib.mkDefault "DLNA MEDIA";
            media_dir = lib.mkDefault [ "PVA,/dlna" ];
            log_level = "warning";
            inotify = "yes";
            wide_links = "yes";
            network_interface = lib.optional (
              config.dlna-network-interface != null
            ) config.dlna-network-interface;
            port = lib.mkDefault 8200;
          };

          # Should open 8200 and 1900 (UPnP)
          openFirewall = lib.mkDefault true;
        };

        users.users.minidlna = {
          # isNormalUser = false;
          extraGroups = [ "users" ]; # so minidlna can access the files.
        };
      };
    };
}
