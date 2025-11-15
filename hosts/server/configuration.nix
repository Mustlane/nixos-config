{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../default.nix
      inputs.sops-nix.nixosModules.sops
    ];

  klipper.enable = lib.mkForce true;

  sops.defaultSopsFile = ./extras/secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/root/.config/sops/age/keys.txt";

  sops.secrets."services/users/mustlane".neededForUsers = true;
  sops.secrets."services/users/root".neededForUsers = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos_server";

  networking.networkmanager = {
    enable = true;
    ensureProfiles.profiles = {
      home-wifi = {
        connection = {
          id = "home-wifi";
          permissions = "";
          type = "wifi";
        };
        ipv4 = {
          dns-search = "";
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          dns-search = "";
          method = "auto";
        };
        wifi = {
          mac-address-blacklist = "";
          mode = "infrastructure";
          ssid = "NarvaBrand";
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "LasteaedKakuke";
        };
      };
    };
  };

  time.timeZone = "Europe/Tallinn";

  i18n.defaultLocale = "en_US.UTF-8";

  users.mutableUsers = false;

  users.users.mustlane = {
    isNormalUser = true;
    description = "Grigori Tsoganov";
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/mustlane";
    packages = with pkgs; [
      fastfetch
      tree
      git
      age
      sops
      weechat-unwrapped
      tldr
    ];
    hashedPasswordFile = config.sops.secrets."services/users/mustlane".path;
  };

  users.users.root = {
    hashedPasswordFile = config.sops.secrets."services/users/root".path;
    home = "/root";
    group = "root";
    extraGroups = [ "root" "bin" "daemon" "sys" "disk" "wheel" "log"];
    uid = 0;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 330 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];

  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
    ports = [330];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password";
  };
};

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.logind.lidSwitchDocked = "ignore";

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
