{ pkgs, lib, config, ... }: {
  options = {
    postgresql.enable =
      lib.mkEnableOption "enables postgresql";
};

config = lib.mkIf config.postgresql.enable {
  services.postgresql = {
    enable = true;
    settings.port = 5432;
    ensureDatabases = [ "mustlane" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust
      # ... other auth rules ...

      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust
    '';
    };
  };
}
