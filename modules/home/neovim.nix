{ config, pkgs, ... }:

{
  #home.username = "your-user";
  #home.homeDirectory = "/home/tomas";

  #programs.home-manager.enable = true;

  # 1. Neovim aktivieren und Aliase setzen
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
  };

  # 2. Kickstart-Konfigurationsordner deklarativ verlinken
  xdg.configFile."nvim" = {
    source = ./nvim;  # Relativer Pfad zu deinem Kickstart-Verzeichnis aus Schritt 1
    recursive = true;
  };
}
