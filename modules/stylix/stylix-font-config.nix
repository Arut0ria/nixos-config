{ self, ... }:
{
  flake.nixosModules.stylix-font-config =
    { pkgs, lib, ... }:
    {
      config = {
        stylix = {
          fonts.sizes = {
            applications = lib.mkDefault 12;
            terminal = lib.mkDefault 12;
          };

          fonts = {
            serif = {
              package = pkgs.noto-fonts-cjk-serif;
              name = "Noto Serif";
            };

            sansSerif = {
              package = pkgs.noto-fonts-cjk-sans;
              name = "Noto Sans";
            };

            monospace = {
              package = pkgs.departure-mono;
              name = "Departure Mono";
              # package = pkgs.jetbrains-mono;
              # name = "JetBrains Mono";
            };

            emoji = {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
            };
          };
        };
      };
    };
}
