{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../default.nix
    ];

  sops.defaultSopsFile = ./extras/secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

  sops.secrets."services/users/andrei".neededForUsers = true;
  sops.secrets."services/users/root".neededForUsers = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.nvidiaSettings = true;

  programs.kdeconnect.enable = true;

  programs.nix-ld.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
  networking.firewall.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  zramSwap = {
    enable = true;
  };
 
  users = {
    mutableUsers = false;
    users.andrei = {
      isNormalUser = true;
      home = "/home/andrei";
      description = "Main user";
      extraGroups = [
        "wheel"
      ];
      shell = pkgs.zsh;
      hashedPasswordFile = config.sops.secrets."services/users/mustlane".path;
    };
    users.root = {
      hashedPasswordFile = config.sops.secrets."services/users/root".path;
    };
  };

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    dejavu_fonts
  ];

  environment.systemPackages = with pkgs; [
    firefox
    libreoffice-qt-fresh
  ];
}
