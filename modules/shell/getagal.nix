{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      config = {
        packages.getagal = inputs.getagal.packages.${system}.default;
      };
    };
}
