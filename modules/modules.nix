{ lib, ... }:
let
  matchModule = (path: (builtins.match ".*module\\.nix$" (builtins.toString path)) != null);
  files = lib.filter (entry: matchModule entry) (lib.filesystem.listFilesRecursive ./.);
in
files
