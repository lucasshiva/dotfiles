{ lib, ... }:

{
  options.my.configDir = lib.mkOption {
    type = lib.types.path;
    description = "Path to home-manager configuration";
  };
}
