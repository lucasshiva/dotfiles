{ lib, config, ... }:
let
  configFile = builtins.toString ./config.kdl;
in
{
  xdg.configFile = {
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink configFile;
  };
}
