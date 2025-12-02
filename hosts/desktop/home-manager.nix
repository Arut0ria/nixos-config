{ lib, inputs, config, pkgs, ... }:
let
  inherit (inputs.self) homeModules;
  inherit (config) me;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [
      inputs.plasma-manager.homeModules.plasma-manager
    ];

    users.${me.username} = {
      home = {
        username = "${me.username}";
        homeDirectory = "/home/${me.username}";
        stateVersion = "25.05";
      
        # Adding face to home
        file.".face.icon" = lib.mkIf (builtins.hasAttr "res" pkgs)  {
          source = builtins.toPath "${pkgs.res}/res/sddm_icon.png";
        };
      };

      imports = [
        # Importing user config for home modules
        homeModules.config-module

        homeModules.plasma-manager-config
        homeModules.cli-module
        homeModules.shell-module
        homeModules.ide-module
        homeModules.programs-module

        homeModules.games-module

        {
          # Options override
          config.zsh-module.charPixelSize = 12 * 1.999;

          config.btop-module.useCuda = true;
          # config.zsh-module.getagalPattern = "(?i).*bath.*(middle|close).*\.(jpe?g|png|gif|bmp|webp)$";
        }
      ];
    };
  };
}
