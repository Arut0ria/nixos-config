{
  ...
}:
{
  flake.homeModules.ranger =
    {
      lib,
      ...
    }:
    {
      config = {
        programs.ranger = {
          enable = true;
          settings = {
            preview_images_method = lib.mkDefault "kitty";
          };
        };
      };
    };
}
