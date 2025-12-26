{ lib, config, ... }:
let
  niriConfig = builtins.toString ./config.kdl;
  mkLink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  xdg.configFile = {
    "niri/config.kdl".source = mkLink niriConfig;
  };
}
