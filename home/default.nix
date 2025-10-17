{ pkgs, lib, ... }: {

  imports = [
    ./modules/zsh/zsh.nix
    ./modules/sway/sway.nix
    ./modules/foot/foot.nix
    ./modules/kitty/kitty.nix
    ./modules/git/git.nix
    ./modules/cliphist/cliphist.nix
    ./modules/firefox/firefox.nix
    ./modules/neovim/neovim.nix
    ./modules/nix-index/nix-index.nix
  ];

  zsh.enable = true;
  sway.enable = true;
  foot.enable = true;
  kitty.enable = true;
  git.enable = true;
  cliphist.enable = true;
  firefox.enable = true;
  neovim.enable = true;
  nix-index.enable = true;
}
