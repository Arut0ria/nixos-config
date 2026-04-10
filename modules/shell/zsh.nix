{
  inputs,
  self,
  ...
}:
/**
  To be generic use : pt * 1.333
  Else : pt * (DPI / 72)
  Current good size = 432, ratio of 1.999, need to get DPI properly
*/
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
          default = "$HOME/.cache/oh-my-zsh/";
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

        zsh-history-file = lib.mkOption {
          type = lib.types.str;
          default = "$HOME/.zsh_history";
        };
      };

      config =
        let
          fastfetch_image = pkgs.fastfetch.override { imageSupport = true; };
        in
        {
          extraPackages = with pkgs; [
            git
            zsh-powerlevel10k
            chafa
            fastfetch_image

            zsh-fast-syntax-highlighting
            zsh-autosuggestions
          ];

          zshAliases =
            let
              getagal = self.packages.${pkgs.stdenv.hostPlatform.system}.getagal;
              fastfetch = lib.getExe fastfetch_image;
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
              ZSH_CACHE_DIR="${config.zsh-cache-dir}";
              ZSH_AUTOSUGGEST_STRATEGY=(history)
              HISTFILE="${config.zsh-history-file}"
              HELPDIR="${pkgs.zsh}/share/zsh/$ZSH_VERSION/help"
            '';
          };

          zshrc = {
            content = ''
              # On s'assure que les chemins sont uniques
              typeset -U path cdpath fpath manpath

              # Boucle sur les profils Nix pour l'autocomplétion
              for profile in ''${(z)NIX_PROFILES}; do
                fpath+=(
                  "$profile/share/zsh/site-functions"
                  "$profile/share/zsh/$ZSH_VERSION/functions"
                  "$profile/share/zsh/vendor-completions"
                )
              done

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

              pattern=$(<$HOME/.config/getagal/pattern)

              bindkey "^[[1;5C" forward-word
              bindkey "^[[1;5D" backward-word

              # oh-my-zsh
              plugins=(git docker)
              source $ZSH/oh-my-zsh.sh

              # History
              HISTSIZE="10000"
              SAVEHIST="10000"
              setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
              unsetopt APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS

              # p10k
              source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
              if [ ! -f $HOME/.p10k.zsh ]; then
                ZDOTDIR=$HOME p10k configure
              else
                source $HOME/.p10k.zsh
              fi

              # SyntaxHighlighting
              source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

              # Autosuggestion
              source ${pkgs.zsh-autosuggestions}/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

              fs # Running fastfetch
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
}
