{ lib, config, ... }:
let
  configFile = builtins.toString ./kitty.conf;
in
{
  xdg.configFile = {
    "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink configFile;
  };
}
