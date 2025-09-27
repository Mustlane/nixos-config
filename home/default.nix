{ pkgs, lib, ... }: {

  imports = [
    ./modules/zsh/zsh.nix
    ./modules/sway/sway.nix
    ./modules/foot/foot.nix
    ./modules/kitty/kitty.nix
    ./modules/git/git.nix
  ];

  zsh.enable = true;
  sway.enable = true;
  foot.enable = true;
  kitty.enable = true;
  git.enable = true;
}
