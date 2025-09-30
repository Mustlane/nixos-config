{ pkgs, lib, ... }: {

  imports = [
    ./nixos/pavucontrol/pavucontrol.nix
    ./nixos/flameshot/flameshot.nix
    ./nixos/ksnip/ksnip.nix
  ];

  pavucontrol.enable = true;
  flameshot.enable = false;
  ksnip.enable = false;
}
