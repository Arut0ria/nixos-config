{ pkgs, ... }:
with pkgs;
[
  git
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget

  # Formatters
  nixpkgs-fmt
  nixfmt-rfc-style
  black
  deno
  djlint

  vlc
  blender
  inkscape
  nh
  p7zip
  rar
  htop
  libreoffice
  tree
  imagemagick

  sbctl

  tty-clock
  deluge
  playerctl

  vulkan-tools
  wineWowPackages.stable
  winetricks
  wineWowPackages.waylandFull

  gimp
  inkscape
  easyeffects
  lmms
  vital

  devenv
  direnv

  wl-clipboard
]
