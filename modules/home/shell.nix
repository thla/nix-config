{ pkgs, ... }:

{
  home.sessionPath = [ "$HOME/.cargo/bin" ];

  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;

  };
}
