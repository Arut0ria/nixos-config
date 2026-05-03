{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nixos-desktop-home =
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

        sharedModules = [
          inputs.plasma-manager.homeModules.plasma-manager
        ];

        users.${me.username} = {
          home = {
            username = "${me.username}";
            homeDirectory = "/home/${me.username}";
            stateVersion = "25.11";
          };

          # Overrides
          btop-use-cuda = lib.mkForce true;

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
