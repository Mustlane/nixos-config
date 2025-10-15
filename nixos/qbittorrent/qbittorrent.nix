{ pkgs, lib, config, ... }: {

  options = {
    qbittorrent.enable =
      lib.mkEnableOption "enables qbittorrent";
};

config = lib.mkIf config.qbittorrent.enable {
    services.qbittorrent = {
      enable = true;
      user = "mustlane";
      webuiPort = 8081;
      torrentingPort = 7451;
      openFirewall = true;
    };
  };
}
