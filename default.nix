{ pkgs, lib, ... }: {

  imports = [
    ./nixos/ksnip/ksnip.nix
    ./nixos/postgresql/postgresql.nix
    ./nixos/steam/steam.nix
    ./nixos/qbittorrent/qbittorrent.nix
    ./nixos/jellyfin/jellyfin.nix
    ./nixos/klipper/klipper.nix
  ];

  ksnip.enable = false;
  postgresql.enable = true;
  steam.enable = true;
  qbittorrent.enable = true;
  jellyfin.enable = false;
  klipper.enable = false;
}
