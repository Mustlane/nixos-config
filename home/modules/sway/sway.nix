{ pkgs, lib, config, ... }:
  let
    a = "#ffffff";
    b = "#000000";
    c = "#333333";
    d = "#5f676a";
    e = "#0c0c0c";
    f = "#900000";
# L: 31
    g = "#77283B";
    h = "#222222";
  in
  {

  options = {
    sway.enable =
      lib.mkEnableOption "enables sway";
};

config = lib.mkIf config.sway.enable {
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty"; 
      colors = {
        background = "${a}";
        focused = {
          background = "${g}";
# L: 45
          border = "#AC3950";
          childBorder = "${g}";
# S: 95 L: 57
          indicator = "#F62C61";
          text = "${a}";
        };
        focusedInactive = {
          background = "${d}";
          border = "${c}";
          childBorder = "${d}";
          indicator = "#484e50";
          text = "${a}";
        };
        unfocused = {
          background = "${h}";
          border = "${c}";
          childBorder = "${h}";
          indicator = "#292d2e";
          text = "#888888";
        };
        urgent = {
          background = "${f}";
          border = "#2f343a";
          childBorder = "${f}";
          indicator = "${f}";
          text = "${a}";
        };
        placeholder = {
          background = "${e}";
          border = "${b}";
          childBorder = "${e}";
          indicator = "${b}";
          text = "${a}";
        };
      };
    };
    extraConfig = ''
      primary_selection disabled
      output * bg /etc/nixos/home/bg/wallhaven1.png fill
      bindsym Mod4+o exec grim -g "$(slurp -d)" -t png - | wl-copy -t image/png
      bindsym Mod4+p exec grim -g "$(slurp -d)" -t png - | tee "$HOME/Screenshots"/"Screenshot_$(date +%Y%m%d-%H%M%S).png"
      bindsym Mod4+i exec hyprpicker -a
      input type:keyboard {
        xkb_layout us,ru
        xkb_options grp:alt_shift_toggle
      }
      '';
    };
  };
}
