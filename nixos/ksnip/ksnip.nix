{ pkgs, lib, config, ... }: {

  options = {
    ksnip.enable =
      lib.mkEnableOption "enables ksnip";
};

config = lib.mkIf config.ksnip.enable {
  environment.systemPackages = [
      pkgs.ksnip
    ];
  };
}
