{
  inputs,
  self,
  ...
}:
# let
#   /**
#     To be generic use : pt * 1.333
#     Else : pt * (DPI / 72)
#     Current good size = 432, ratio of 1.999, need to get DPI properly
#   */
#   # dpi = 96 * 1.25; # Laptop is 96
#   # char_pixel_size = toString (config.stylix.fonts.sizes.terminal * (dpi / 72.0));
#
#   useFastFetchConfig = (builtins.hasAttr "fastfetch" pkgs) && (builtins.hasAttr "getagal" pkgs);
#   fastfetchConfig = (
#     charSize: pattern:
#     lib.optionalString useFastFetchConfig ''
#       char_pixel_size=${builtins.toString charSize}
#       fastfetch_number_of_line=18
#       image_height=$(printf %.0f $((fastfetch_number_of_line * char_pixel_size)))
#
#       pattern_file="$HOME/.config/getagal/pattern"
#       mkdir -p "$(dirname "$pattern_file")"
#       [ ! -f "$pattern_file" ] && echo "${pattern}" > "$pattern_file"
#
#       pattern=$(<~/.config/getagal/pattern)
#       alias fs='${pkgs.fastfetch}/bin/fastfetch --kitty-direct $(${pkgs.getagal}/bin/getagal -s ${pkgs.getagal}/share/images -n $image_height -p "$pattern")'
#
#       fs # Runnings fastfetchs
#     ''
#   );
#
#   inherit (config.home) homeDirectory;
# in
{
  flake.wrapperModules.zsh-config =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options = {
        zsh-cache-dir = lib.mkOption {
          type = lib.types.str;
          default = "~/.cache/oh-my-zsh/";
        };

        zsh-char-size = lib.mkOption {
          type = lib.types.number;
          default = 12 * 1.99;
        };

        zsh-getagal-pattern = lib.mkOption {
          type = lib.types.str;
          description = "The pattern used by getagal to fetch images.";
          default = "(?i).*(middle|close).*\.(jpe?g|png|gif|bmp|webp)$";
        };
      };

      config = {
        extraPackages = with pkgs; [
          git
          zsh-powerlevel10k
          (fastfetch.override {
            imageSupport = true;
          })
          chafa
        ];

        zshAliases =
          let
            getagal = self.packages.${pkgs.stdenv.hostPlatform.system}.getagal;
            fastfetch = lib.getExe pkgs.fastfetch;
          in
          {
            fs = ''
              img_path=$(${lib.getExe getagal} -s ${getagal}/share/images -n $image_height -p "$pattern")

              if [ -n "$KITTY_WINDOW_ID" ] || [ "$TERM" = "xterm-kitty" ]; then
                ${fastfetch} --kitty-direct "$img_path"
              else
                ${fastfetch} --chafa "$img_path" --chafa-symbols braille --chafa-fg-only
              fi
            '';
          };

        zshenv = {
          content = ''
            ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh;
            ZSH_CACHE_DIR=${config.zsh-cache-dir};
          '';
        };

        zshrc = {
          content = ''
            # kitty-integration
            if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
              export KITTY_SHELL_INTEGRATION="enabled"
              autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
              kitty-integration
              unfunction kitty-integration
            fi

            char_pixel_size=${builtins.toString config.zsh-char-size}
            fastfetch_number_of_line=18
            image_height=$(printf %.0f $((fastfetch_number_of_line * char_pixel_size)))

            pattern_file="$HOME/.config/getagal/pattern"
            mkdir -p "$(dirname "$pattern_file")"
            [ ! -f "$pattern_file" ] && echo "${config.zsh-getagal-pattern}" > "$pattern_file"

            pattern=$(<~/.config/getagal/pattern)

            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word

            # oh-my-zsh
            plugins=(git docker)
            source $ZSH/oh-my-zsh.sh

            # p10k
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            if [ ! -f ~/.p10k.zsh ]; then
              ZDOTDIR=~ p10k configure
            else
              source ~/.p10k.zsh
            fi

            # fs # Running fastfetch
          '';
        };
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.zsh = inputs.nix-wrappers-modules.wrappers.zsh.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.zsh-config ];
      };
    };
  # options = {
  #   zsh-module.enable = lib.mkEnableOption "Enables zsh.";
  #
  #   zsh-module.getagalPattern = lib.mkOption {
  #     type = lib.types.str;
  #     description = "The pattern used by getagal to fetch images.";
  #     default = "(?i).*(middle|close).*\.(jpe?g|png|gif|bmp|webp)$";
  #   };
  #
  #   zsh-module.charPixelSize = lib.mkOption {
  #     type = lib.types.number;
  #     description = "Char pixel size used to scale the image displayed upon fastfetch call.";
  #     default = 12 * 1.99;
  #   };
  # };
  #
  # config = lib.mkIf config.zsh-module.enable {
  #   programs.zsh = {
  #     enable = true;
  #     enableCompletion = true;
  #     autosuggestion.enable = true;
  #     syntaxHighlighting.enable = true;
  #
  #     initContent = ''
  #       bindkey "^[[1;5C" forward-word
  #       bindkey "^[[1;5D" backward-word
  #       [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh
  #
  #       alias copyconfig='sudo cp -r ${homeDirectory}/nixos-config/* /etc/nixos/'
  #     ''
  #     + (fastfetchConfig config.zsh-module.charPixelSize config.zsh-module.getagalPattern);
  #
  #     oh-my-zsh = {
  #       enable = true;
  #       plugins = lib.mkMerge [
  #         [ "git" ]
  #         [ "docker" ]
  #         # (lib.mkIf (config.docker-service.enable) ["docker"])
  #       ];
  #     };
  #
  #     zplug = {
  #       enable = true;
  #       plugins = [
  #         {
  #           name = "romkatv/powerlevel10k";
  #           tags = [
  #             "as:theme"
  #             "depth:1"
  #           ];
  #         }
  #       ];
  #     };
  #   };
  # };
}
