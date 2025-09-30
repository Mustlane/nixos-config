{ pkgs, lib, config, ... }: {

  options = {
    flameshot.enable =
      lib.mkEnableOption "enables flameshot";
};

config = lib.mkIf config.flameshot.enable {
  environment.systemPackages = [
      pkgs.flameshot
    ];
  nixpkgs.config.packageOverrides = pkgs: {
    flameshot = pkgs.flameshot.override { enableWlrSupport = true; };
    };
  };
}
