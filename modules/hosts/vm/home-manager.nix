{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nixos-vm-home =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
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
            stateVersion = "25.11";
          };

          imports = [
            self.homeModules.me-module
            self.homeModules.sddm-face
            self.homeModules.plasma-manager-config
            self.homeModules.kitty-config
            self.homeModules.firefox

            # Importing user config for home modules
            # homeModules.config-module
            #
            # homeModules.plasma-manager-config
            # homeModules.cli-module
            # homeModules.shell-module
            # homeModules.ide-module
            # homeModules.programs-module

            # {
            #   # Options override
            #   config.zsh-module.charPixelSize = 10 * 1.333;
            #   config.zsh-module.getagalPattern = "(?i).*bath.*(middle|close).*\.(jpe?g|png|gif|bmp|webp)$";
            # }
          ];
        };
      };
    };
}
