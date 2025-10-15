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

  sops.secrets."services/users/mustlane".neededForUsers = true;
  sops.secrets."services/users/root".neededForUsers = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.graphics.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
  networking.firewall.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
      KernelExperimental = true;
      Enable = "Source,Sink,Media,Socket";
  };
    Policy = {
      AutoEnable = true;
    };
  };
};

  services.blueman.enable = true;
  security.polkit.enable = true;
  programs.zsh.enable = true;

  users = {
    mutableUsers = false;
    users.mustlane = {
      isNormalUser = true;
      home = "/home/mustlane";
      description = "Main user";
      extraGroups = [
        "wheel"
        "networkmanager"
        "postgres"
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
    ungoogled-chromium
    libreoffice-qt-fresh
    bluez
    bluez-tools
    blueman
    dbeaver-bin
    youtube-music
    pnpm_9
    nodejs_24
    tree
    vscode
    postgresql_18
    btop
    tldr
    tor
    tor-browser-bundle-bin
    feh
    vesktop
    inkscape
    imagemagick
    bat
    wl-clipboard
    grim
    slurp
    hyprpicker
    ytermusic
    youtube-tui
    prusa-slicer
    kicad
    gimp
    age
    sops
    wlprop
    speedtest-cli
  ];
}
