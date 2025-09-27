{ pkgs, lib, ... }: {

  imports = [
    ./nixos/pavucontrol/pavucontrol.nix
  ];

  pavucontrol.enable = true;
}
