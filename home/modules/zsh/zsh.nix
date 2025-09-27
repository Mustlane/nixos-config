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
    initContent = "
                   autoload -Uz vcs_info \n
                   precmd_vcs_info() { vcs_info } \n
                   precmd_functions+=( precmd_vcs_info ) \n
                   setopt prompt_subst \n
                   RPROMPT='${vcs_info_msg_0_}' \n
                   # PROMPT='%F{green}%*%f %F{blue}%~%f' 
                   \n
                   zstyle ':vcs_info:git:*' formats '%b'";
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
