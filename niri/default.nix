{ lib, config, ... }:
let
  configFile = "${config.my.configDir}/niri/config.kdl";
in
{
  xdg.configFile = {
    "niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink configFile;
  };
}
