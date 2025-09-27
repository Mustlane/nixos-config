{ pkgs, lib, config, ... }: {

  options = {
    sway.enable =
      lib.mkEnableOption "enables sway";
};

config = lib.mkIf config.sway.enable {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty"; 
    };
  };
  };
}
