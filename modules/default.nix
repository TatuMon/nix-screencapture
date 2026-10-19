{
  config,
  pkgs,
  unstablePkgs,
  lib,
  ...
}:
let
  screenCaptureConf = config.services.screencapture;
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  options.services.screencapture = {
    enable = lib.mkEnableOption "Screencapture";
  };

  config = lib.mkIf screenCaptureConf.enable {
    services.flameshot.enable = isLinux;

    home.packages = lib.optionals isDarwin [
      unstablePkgs.macshot
    ];
  };
}
