{ pkgs, lib, config, ... }: {

  options = {
    foot.enable =
      lib.mkEnableOption "enables foot";
};

config = lib.mkIf config.foot.enable {
  programs.foot = {
    enable = true;
    };
  };
}
