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

        # Adding face to home
        file.".face.icon" = lib.mkIf (builtins.hasAttr "res" pkgs) {
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
          config.zsh-module.charPixelSize = 10 * 1.333;
        }
      ];

      # Need to test zsh-module directly without config -> here
    };
  };
}
