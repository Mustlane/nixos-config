{ pkgs, lib, config, ... }: {

  options = {
    steam.enable =
      lib.mkEnableOption "enables steam";
};

config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworGameTransfers.openFirewall = true;
    };
  };
}
