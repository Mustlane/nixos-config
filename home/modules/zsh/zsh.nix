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
      '';
    oh-my-zsh = {
        enable = true;
        plugins = [ "rbw" "copyfile" "copypath" "sudo" "git" ];
      };
    shellAliases = {
      rebuild-switch = "sudo nixos-rebuild switch --flake /etc/nixos";
      };
    };
  };
}
