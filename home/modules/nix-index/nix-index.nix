{ pkgs, lib, config, ... }: {

  options = {
    nix-index.enable =
      lib.mkEnableOption "enables nix-index";
};

config = lib.mkIf config.nix-index.enable {
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    };
  };
}
