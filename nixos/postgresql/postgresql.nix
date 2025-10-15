{ pkgs, lib, config, ... }: {
  options = {
    postgresql.enable =
      lib.mkEnableOption "enables postgresql";
};

config = lib.mkIf config.postgresql.enable {
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mustlane" ];
    };
  };
}
