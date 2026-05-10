{
  inputs,
  self,
  moduleWithSystem,
  ...
}:
{
  flake.wrapperModules.niri-config = moduleWithSystem (
    perSystem@{
      system,
      self',
      ...
    }:
    nixos@{
      pkgs,
      config,
      lib,
      ...
    }:
    {
      options = { };
      config = {
        extraPackages =
          with self'.packages;
          [
            zsh
          ]
          ++ (with pkgs; [
            kitty
          ]);

        extraSettings = [
          {
            include = [
              { optional = true; }
              "~/.config/niri/config.kdl"
            ];
          }
        ];

        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.noctalia)
          ];

          input = {
            keyboard = {
              xkb = {
                layout = "fr";
                options = "grp:alt_shift_toggle,caps:escape";
              };
            };
            mouse = {
              accel-profile = "flat";
            };
          };

          layout = {
            gaps = 5;
            focus-ring = {
              width = 2;
            };
          };

          layer-rules = [
            {
              place-within-backdrop = true;
              matches = [
                {
                  namespace = "^noctalia-overview*";
                }
              ];
            }
            {
              matches = [
                {
                  namespace = "^noctalia-(background|launcher-overlay|dock)-.*$";
                }
              ];
              background-effect = {
                xray = false;
              };
            }
          ];

          window-rules = [
            {
              background-effect = {
                blur = true;
                xray = false;
              };
              geometry-corner-radius = 20;
              clip-to-geometry = true;
            }
          ];

          prefer-no-csd = _: { };

          xwayland-satellite.path = lib.getExe config.pkgs.xwayland-satellite;

          blur = {
            passes = 2;
            offset = 3.0;
            noise = 0.03;
            saturation = 1.0;
          };

          binds = {
            "Mod+T".spawn-sh = lib.getExe pkgs.kitty;
            "Mod+Q".close-window = _: { };

            "Mod+Ctrl+Right".focus-column-right = _: { };
            "Mod+Ctrl+Left".focus-column-left = _: { };
            "Mod+Ctrl+Up".focus-workspace-up = _: { };
            "Mod+Ctrl+Down".focus-workspace-down = _: { };

            "Mod+Shift+Ctrl+Up".move-window-up = _: { };
            "Mod+Shift+Ctrl+Down".move-window-down = _: { };
            "Mod+Shift+Ctrl+Right".move-column-right = _: { };
            "Mod+Shift+Ctrl+Left".move-column-left = _: { };

            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

            "Mod+Shift+F".toggle-window-floating = _: { };
            "Mod+F".maximize-column = _: { };
            "Mod+G".fullscreen-window = _: { };
          };
        };
      };
    }
  );

  perSystem =
    { pkgs, system, ... }:
    let
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
    in
    {
      packages.niri = inputs.nix-wrappers-modules.wrappers.niri.wrap {
        inherit pkgs;
        package = pkgs-unstable.niri;
        imports = [ self.wrapperModules.niri-config ];
      };
    };
}
