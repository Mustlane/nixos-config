{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../default.nix
    ];

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

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mustlane" ];
};

security.polkit.enable = true;

  programs.zsh.enable = true;

  users.users.mustlane = {
    isNormalUser = true;
    home = "/home/mustlane";
    description = "Main user";
    extraGroups = [
      "wheel"
      "networkmanager"
      "postgres"
    ];
    shell = pkgs.zsh;
  };

programs = {
  firefox = {
    enable = true;
  };
  neovim = {
    enable = true;
  };
};

nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    dejavu_fonts
  ];

  environment.systemPackages = with pkgs; [
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
    ksnip
    bat
    wl-clipboard
];
}
