{ pkgs, lib, config, ... }: {

  options = {
    zsh.enable =
      lib.mkEnableOption "enables zsh";
};

config = lib.mkIf config.zsh.enable {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
      };
    syntaxHighlighting.enable = true;
    initContent = ''
      autoload -Uz vcs_info
      setopt PROMPT_SUBST
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats ' %F{#FFFFFF}%b%f'
      PROMPT='%F{#C1B492}[%f%F{#D2738A}%n%f@%F{#D2738A}%m%f:%F{#D2738A}%d%f''${vcs_info_msg_0_}%F{#C1B492}]$%f '

      function removehist {
        if [ "$1" != "" ]
        then
          LC_ALL=C sed -i "/''$1/d" "''$HISTFILE"
        else
          echo "You forgot to give parameter, dumbass"
        fi
      }

      function onlinefix {
        for arg in "$@"; do
          case $arg in
            ror2)
              GAMEPATH="/home/mustlane/Games/Risk of Rain 2/Risk of Rain 2/Risk of Rain 2.exe"
            ;;
            gunfirereborn)
              GAMEPATH="/home/mustlane/Games/Gunfire Reborn/Gunfire Reborn/Gunfire Reborn.exe"
            ;;
            guntouchables)
              GAMEPATH="/home/mustlane/Games/GUNTOUCHABLES/GUNTOUCHABLES/Launcher.exe"
          esac
        done
      WINEPREFIX='/home/mustlane/.480' \
      WINEDLLOVERRIDES="OnlineFix64=n;SteamOverlay64=n;winmm=n,b;dnet=n;steam\_api64=n" \
      GAMEID=480 \
      PROTONPATH='/home/mustlane/.local/share/Steam/steamapps/common/Proton 10.0' \
      umu-run "$GAMEPATH"
      }
      '';
    oh-my-zsh = {
        enable = true;
        plugins = [ "rbw" "copyfile" "copypath" "sudo" "git" ];
      };
    shellAliases = {
      rebuild-switch = "sudo nixos-rebuild switch --flake /etc/nixos --impure";
      nvidia-stats = "nvidia-smi";
      };
    };
  };
}
