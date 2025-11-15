{ pkgs, lib, ... }: {

  imports = [
    ./ksnip/ksnip.nix
    ./postgresql/postgresql.nix
    ./steam/steam.nix
    ./qbittorrent/qbittorrent.nix
    ./jellyfin/jellyfin.nix
    ./klipper/klipper.nix
  ];

  ksnip.enable = false;
  postgresql.enable = true;
  steam.enable = true;
  qbittorrent.enable = true;
  jellyfin.enable = false;
  klipper.enable = false;
}
