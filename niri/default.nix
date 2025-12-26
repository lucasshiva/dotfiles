{ lib, config, ... }:
let
  niriConfig = builtins.toString ./config.kdl;
  dmsDir = builtins.toString ./dms;
  mkLink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  # Maybe in the future we could toggle which DMS files to symlink.
  xdg.configFile = {
    "niri/config.kdl".source = mkLink niriConfig;
    "niri/dms/alttab.kdl".source = mkLink "${dmsDir}/alttab.kdl";
    "niri/dms/binds.kdl".source = mkLink "${dmsDir}/binds.kdl";
    "niri/dms/colors.kdl".source = mkLink "${dmsDir}/colors.kdl";
    "niri/dms/layout.kdl".source = mkLink "${dmsDir}/layout.kdl";
    "niri/dms/wpblur.kdl".source = mkLink "${dmsDir}/wpblur.kdl";
  };
}
