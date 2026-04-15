{
  ...
}:
{
  flake.nixosModules.game-packages =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      options = {
        protonup-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        bottles-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        heroic-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        gamemode-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        minecraft-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };
      };

      config =
        let
          inherit (config) me;
        in
        {
          environment.systemPackages = lib.mkMerge (
            with pkgs;
            [
              (lib.optionals config.protonup-enable [ protonup-ng ])
              (lib.optionals config.bottles-enable [ bottles ])
              (lib.optionals config.heroic-enable [ heroic ])
              (lib.optionals config.minecraft-enable [ prismlauncher ])
            ]
          );

          programs.gamemode = {
            enable = lib.mkDefault true;
            enableRenice = lib.mkDefault true;

            settings = {
              general = {
                softrealtime = "auto";
                renice = 10;
              };
            };
          };

          # Adding user to gamemode group if necessary
          users.groups.gamemode.members = [ me.username ];
        };
    };
}
