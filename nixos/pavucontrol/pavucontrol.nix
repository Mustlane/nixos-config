{ pkgs, lib, config, ... }: {

  options = {
    pavucontrol.enable =
      lib.mkEnableOption "enables pavucontrol";
};

config = lib.mkIf config.pavucontrol.enable {
  environment.systemPackages = [
      pkgs.pavucontrol
    ];
  };
}
