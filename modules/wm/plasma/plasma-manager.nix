{ pkgs, config, lib, ... }@inputs: {
  options = {
    plasma-manager-config.enable = lib.mkEnableOption "Enables plasma manager config.";
    # plasmusic-displaycontrols = lib.mkOption {
    #   type = lib.types.bool;
    #   default = true;
    # };
    # plasmusic-maxWidth = lib.mkOption {
    #   type = lib.types.ints.unsigned;
    #   default = 640;
    # };
  };

  config = lib.mkIf config.plasma-manager-config.enable {
    # nixpkgs.overlays = [
    #   (final: prev: {
    #     plasmusic-toolbar = (import inputs.inputs.nixpkgs-unstable { system = final.system; }).plasmusic-toolbar;
    #     polonium = (import inputs.inputs.nixpkgs-unstable { system = final.system; }).polonium;
    #     # polonium = prev.libsForQt5.polonium;
    #   })
    # ];

    # environment.systemPackages = with pkgs; [ plasmusic-toolbar ];
    # home.packages = with pkgs; [
    #   plasmusic-toolbar
    # ];

    programs.plasma = {
      enable = true;

      # Hotkeys
      hotkeys.commands."launch-kitty" = {
        name = "Launch Kitty";
        key = "Meta+Ctrl+T";
        command = "kitty";
      };

      # Panel Setup
      panels = [
        {
          screen = "all";
          location = "bottom";
          hiding = "none";
          floating = true;
          alignment = "center";
          lengthMode = "fill";

          widgets = [
            # "org.kde.plasma.kickoff"
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-colours";
                size = {
                  width = 48;
                  height = 48;
                };
              };
            }
            "org.kde.plasma.pager"

            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.icontasks"
            "org.kde.plasma.panelspacer"
            "org.kde.plasma.marginsseparator"

            # {
            #   plasmusicToolbar = {
            #     panelIcon = {
            #       albumCover = {
            #         useAsIcon = true;
            #         radius = 8;
            #       };
            #       icon = "view-media-track";
            #     };
            #     # preferredSource = "spotify";
            #     musicControls.showPlaybackControls = config.plasmusic-displaycontrols;
            #     songText = {
            #       displayInSeparateLines = false;
            #       maximumWidth = config.plasmusic-maxWidth;
            #       scrolling = {
            #         behavior = "alwaysScroll";
            #         speed = 3;
            #       };
            #     };
            #   };
            # }

            # "org.kde.plasma.systemtray"

            {
              systemTray.items = {
                shown = [
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.volume"
                ];
                hidden = [
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.clipboard"
                ];
              };
            }
            "org.kde.plasma.digitalclock"
            "org.kde.plasma.showdesktop"
          ];
        }

      ];

      window-rules = [
        {
          description = "Kitty Rule";
          match = {
            window-class = {
              value = "kitty";
              type = "substring";
            };
            window-types = [
              "normal"
            ];
          };

          apply = {
            # noborder = {
            #   value = true;
            #   apply = "force";
            # };
            opacityactiverule = {
              value = 2;
              apply = "force";
            };
            opacityinactiverule = {
              value = 2;
              apply = "force";
            };
          };
        }
        {
          description = "Forced Opacity";
          match = { };
          apply = {
            opacityactive = {
              value = 100;
              apply = "force";
            };
            opacityactiverule = {
              value = 2;
              apply = "force";
            };
            opacityinactive = {
              value = 85;
              apply = "force";
            };
            opacityinactiverule = {
              value = 2;
              apply = "force";
            };
          };
        }
      ];

      # Kwin setup
      kwin = {
        edgeBarrier = 0; # Disables the edge-barriers introduced in plasma 6.1
        cornerBarrier = false;

        effects = {
          translucency.enable = true;
          blur.enable = false;
        };

        virtualDesktops = {
          rows = 2;
          number = 4;
        };

        borderlessMaximizedWindows = true;
      };

      # Additional config
      configFile = {
        "kwinrc"."MouseBindings"."CommandAllWheel" = "Change opacity";

        # Blur config
        "kwinrc"."Effect-blurplus"."forceblurEnabled" = true;
        "kwinrc"."Effect-blurplus"."BlurDecorations" = true;
        "kwinrc"."Effect-blurplus"."BlurMatching" = false;
        "kwinrc"."Effect-blurplus"."BlurMenus" = true;
        "kwinrc"."Effect-blurplus"."BlurNonMatching" = true;
        "kwinrc"."Effect-blurplus"."BlurStrength" = 8;
        "kwinrc"."Effect-blurplus"."BottomCornerRadius" = 2;
        "kwinrc"."Effect-blurplus"."DockCornerRadius" = 2;
        "kwinrc"."Effect-blurplus"."MenuCornerRadius" = 2;
        "kwinrc"."Effect-blurplus"."NoiseStrength" = 4;
        "kwinrc"."Effect-blurplus"."TopCornerRadius" = 2;
        "kwinrc"."Effect-blurplus"."WindowClasses" = "kitty\nxwaylandvideobridge";
      } // lib.optionalAttrs (pkgs ? kwin-effects-forceblur) {
        "kwinrc"."Plugins"."forceblurEnabled" = true;
      };
    };

    # Adding breeze config
    home.file."${config.xdg.configHome}/breezerc" = {
      text = ''
        [Common]
        OutlineIntensity=OutlineHigh

        [Windeco Exception 0]
        BorderSize=0
        Enabled=true
        ExceptionPattern=kitty
        ExceptionType=0
        HideTitleBar=true
        Mask=0
      '';
    };
  };
}
