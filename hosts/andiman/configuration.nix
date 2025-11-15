{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
#      ../../nixos/default.nix
    ];

#  sops.defaultSopsFile = ./extras/secrets/secrets.yaml;
#  sops.defaultSopsFormat = "yaml";

#  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

#  sops.secrets."services/users/andrei".neededForUsers = true;
#  sops.secrets."services/users/root".neededForUsers = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "andiman";

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.kdeconnect.enable = true;

  services.openssh.enable = true;

  networking.firewall.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  zramSwap = {
    enable = true;
  };
 
  users = {
    mutableUsers = true;
    users.andrei = {
      isNormalUser = true;
      home = "/home/andrei";
      description = "Main user";
      extraGroups = [
        "wheel"
      ];
#      shell = pkgs.zsh;
#      hashedPasswordFile = config.sops.secrets."services/users/mustlane".path;
    };
#    users.root = {
#      hashedPasswordFile = config.sops.secrets."services/users/root".path;
#    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  ];
}
