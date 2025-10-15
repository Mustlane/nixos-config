{ pkgs, lib, ... }: {

  imports = [
    ./nixos/pavucontrol/pavucontrol.nix
    ./nixos/flameshot/flameshot.nix
    ./nixos/ksnip/ksnip.nix
    ./nixos/postgresql/postgresql.nix
    ./nixos/steam/steam.nix
    ./nixos/wine/wine.nix
    ./nixos/qbittorrent/qbittorrent.nix
    ./nixos/umu-launcher/umu-launcher.nix
  ];

  pavucontrol.enable = true;
  flameshot.enable = false;
  ksnip.enable = false;
  postgresql.enable = true;
  steam.enable = true;
  wine.enable = false;
  qbittorrent.enable = true;
  umu-launcher.enable = true;
}
