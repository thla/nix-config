{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    catppuccin-gtk
    catppuccin-cursors
    catppuccin-kvantum
  ];


  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk;
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors;
      size = 24;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
