{ config, lib, pkgs, ... }: {
  options = {
    plasma-module.enable = lib.mkEnableOption "Enables plasma 6 config (with kde)";
  };

  config = lib.mkIf config.plasma-module.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = [ "gtk" ];
        };
        kde = {
          default = [ "kde" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
          "org.freedesktop.impl.portal.Secret" = [ "kwallet.portal" ];
        };
      };
    };

    services = {
      xserver.enable = true;

      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      printing = {
        enable = true;
        drivers = with pkgs; [
          cups-filters
          cups-browsed
        ];
      };

      displayManager = {
        defaultSession = "plasma";
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };

      desktopManager.plasma6.enable = true;
    };
    
    environment.systemPackages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };
}
