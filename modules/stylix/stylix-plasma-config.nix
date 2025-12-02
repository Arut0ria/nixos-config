{ pkgs, lib, config, ... }:
let
  cfg = config.stylix-plasma-config;
in
{
  options = {
    stylix-plasma-config.enable = lib.mkEnableOption "Enables stylix.";
    stylix-plasma-config.fontSize = lib.mkOption {
      type = lib.types.ints.unsigned;
      default = 12;
    };

    stylix-plasma-config.background = lib.mkOption {
      type = lib.types.str;
      default = if (builtins.hasAttr "res" pkgs) then "${pkgs.res}/res/background_1.png" else "../../res/background_1.png";
      description = "'Name of the background image to use, add to the res directory / package.";
    };

    stylix-plasma-config.logo = lib.mkOption {
      type = lib.types.str;
      default = if (builtins.hasAttr "res" pkgs) then "${pkgs.res}/res/sddm_icon.png" else "../../res/sddm_icon.png";
      description = "Name of the logo to use, using pkgs.res as default.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optionals (builtins.hasAttr "res" pkgs) [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${cfg.background}
      '')
    ];

    # Enable stylix
    stylix = {
      enable = true;
      autoEnable = true;

      fonts.sizes = {
        applications = cfg.fontSize;
      };

      image = cfg.background;

      polarity = "dark";

      opacity = {
        terminal = 0.9;
        popups = 0.9;
        applications = 0.95;
        desktop = 0.9;
      };

      targets = {
        grub.useImage = true;
      };

      override.base05 = "FFFFFF";

      fonts = {
        serif = {
          package = pkgs.noto-fonts-cjk-serif;
          name = "Noto Serif";
        };

        sansSerif = {
          package = pkgs.noto-fonts-cjk-sans;
          name = "Noto Sans";
        };

        monospace = {
          package = pkgs.jetbrains-mono;
          name = "JetBrains Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
