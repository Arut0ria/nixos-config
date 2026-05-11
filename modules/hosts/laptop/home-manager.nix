{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nixos-laptop-home =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (config) me;
    in
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        overwriteBackup = true;

        sharedModules = [
          inputs.plasma-manager.homeModules.plasma-manager
        ];

        users.${me.username} = {
          home = {
            username = "${me.username}";
            homeDirectory = "/home/${me.username}";
            stateVersion = "25.11";
          };

          imports = with self.homeModules; [
            me-module
            sddm-face

            btop
            cava
            fastfetch
            ranger
            mangohud
            discord
            firefox
            kitty-config
          ];
        };
      };
    };
}
