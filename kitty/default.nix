{ lib, config, ... }:
let
  configFile = "${config.my.configDir}/kitty/kitty.conf";
in
{
  xdg.configFile = {
    "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink configFile;
  };
}
