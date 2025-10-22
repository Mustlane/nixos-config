{ pkgs, lib, config, ... }: {

  options = {
    zed-editor.enable =
      lib.mkEnableOption "enables zed-editor";
};

config = lib.mkIf config.zed-editor.enable {
  programs = {
    zed-editor = {
      enable = true;
      extensions = [ "html" "catpuccin" "toml" "nix" "sql" "vue" "catpuccin icons" "scss" "latex" "basher" "liveserver" "postgres language server" "rainbox csv" ];
    };
    userSettings = {
      autosave = "on_focus_change";
      auto_indent = true;
      auto_indent_on_paste = true;
      tab_size = 2;
      indent_guides = {
        enabled = true;
        line_width = 1;
        active_line_width = 1;
        coloring = "fixed";
        background_coloring = "disabled";
      };
      features = {
        edit_prediction_provider = "copilot";
      };
      icon_theme = "Catppuccin Macchiato";
      ui_font_size = 16;
      buffer_font_size = 14;
      theme = {
        mode = "system";
        light = "Catpuccin Frappé";
        dark = "One Dark"
      };
    };
    nixGL.vulkan.enable = true;
  };
}
