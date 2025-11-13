{ pkgs, lib, config, ... }: {

  options = {
    jellyfin.enable =
      lib.mkEnableOption "enables jellyfin";
};

  config = lib.mkIf config.jellyfin.enable {
    services.jellyfin.enable = true;
    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
  };
}
