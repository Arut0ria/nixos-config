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
      inputs.nixvim.homeModules.nixvim
    ];

    users.${me.username} = {
      home = {
        username = "${me.username}";
        homeDirectory = "/home/${me.username}";
        stateVersion = "25.11";
      };

      imports = [
        # Importing user config for home modules
        homeModules.config-module

        homeModules.plasma-manager-config
        homeModules.cli-module
        homeModules.shell-module
        homeModules.ide-module
        homeModules.programs-module

        {
          # Options override
          config.zsh-module.charPixelSize = 10 * 1.333;
          config.zsh-module.getagalPattern = "(?i).*bath.*(middle|close).*\.(jpe?g|png|gif|bmp|webp)$";
        }
      ];
    };
  };
}
