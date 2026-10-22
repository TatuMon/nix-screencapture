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
  useMacshot = isDarwin;
  useFlameshot = isLinux;
in
{
  options.services.screencapture = {
    enable = lib.mkEnableOption "Screencapture";
  };

  config = lib.mkIf screenCaptureConf.enable {
    services.flameshot.enable = useFlameshot;

    home.packages = lib.optionals useMacshot [
      unstablePkgs.macshot
    ];

    launchd.agents."macshot" = {
      enable = useMacshot;
      config = {
        ProgramArguments = [
          "/usr/bin/open"
          "-a"
          "${unstablePkgs.macshot}/Applications/macshot.app"
        ];

        waitForNixStore = false;
        RunAtLoad = true;
        KeepAlive = false;

        StandardOutPath = "${config.home.homeDirectory}/Library/Logs/macshot/stdout";
        StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/macshot/stderr";
      };
    };
  };
}
