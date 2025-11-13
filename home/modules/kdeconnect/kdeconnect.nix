{ pkgs, lib, config, ... }: {

  options = {
    kdeconnect.enable =
      lib.mkEnableOption "enables kdeconnect";
};

  config = lib.mkIf config.kdeconnect.enable {
    services.kdeconnect = {
      enable = true;
    };

#    networking.firewall = rec {
#      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
#      allowedUDPPortRanges = allowedTCPPortRanges;
#    };
  };
}
