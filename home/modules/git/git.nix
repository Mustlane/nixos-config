{ pkgs, lib, config, ... }: {

  options = {
    git.enable =
      lib.mkEnableOption "enables git";
};

config = lib.mkIf config.git.enable {
  programs.git = {
    enable = true;
    userName = "Mustlane";
    userEmail = "gtx2020super@gmail.com";
    lfs.enable = true;
    };
  };
}
