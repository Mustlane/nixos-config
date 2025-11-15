{ config, pkgs, lib, ... }: {

  home.username = "mustlane";
  home.homeDirectory = "/home/mustlane";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  imports = [
    ../../../../home/default.nix
  ];

  sway.enable = lib.mkForce false;
  foot.enable = lib.mkForce false;
  kitty.enable = lib.mkForce false;
  firefox.enable = lib.mkForce false;
  neovim.enable = lib.mkForce false;
  nix-index.enable = lib.mkForce false;
  zed-editor.enable = lib.mkForce false;
}
