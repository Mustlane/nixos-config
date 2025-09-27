{ pkgs, lib, config, ... }: {

  options = {
    kitty.enable =
      lib.mkEnableOption "enables kitty";
};

config = lib.mkIf config.kitty.enable {
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      };  
    };
  };
}
