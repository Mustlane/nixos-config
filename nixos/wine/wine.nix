{ pkgs, lib, config, ... }: {

  options = {
    wine.enable =
      lib.mkEnableOption "enables wine";
};

config = lib.mkIf config.wine.enable {
  environment.systemPackages = with pkgs; [
      wineWowPackages.waylandFull
      winetricks
    ];
  };
}

