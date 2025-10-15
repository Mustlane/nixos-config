{ pkgs, lib, config, ... }: {

  options = {
    umu-launcher.enable =
      lib.mkEnableOption "enables umu-launcher";
};

config = lib.mkIf config.umu-launcher.enable {
  environment.systemPackages = with pkgs; [
      umu-launcher
    ];
  };
}
