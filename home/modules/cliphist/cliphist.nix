{ pkgs, lib, config, ... }: {

  options = {
    cliphist.enable =
      lib.mkEnableOption "enables cliphist";
};

config = lib.mkIf config.cliphist.enable {
  services.cliphist = {
    enable = true;
    };
  };
}
