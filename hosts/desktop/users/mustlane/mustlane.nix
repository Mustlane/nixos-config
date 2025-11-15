{ config, pkgs, lib, ... }: {

  home.username = "mustlane";
  home.homeDirectory = "/home/mustlane";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../../../home/default.nix
  ];
}
