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
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{#C1B492}%b%f'
setopt PROMPT_SUBST
PROMPT='%F{#D2738A}[%f%F{#C1B492}%n@%m%f %F{#D2738A}%d%f''${vcs_info_msg_0_}%F{#C1B492}]$%f '
'';
    oh-my-zsh = {
        enable = true;
        plugins = [ "rbw" "copyfile" "copypath" "sudo" "git" ];
      };
    shellAliases = {
      rebuild-switch = "sudo nixos-rebuild switch --flake";
      };
    };
  };
}
