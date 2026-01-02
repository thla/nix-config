{ config, pkgs, ... }:

{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "25.11";

  imports = [
    ../modules/home/shell.nix
    ../modules/home/git.nix
    ../modules/home/programs.nix
    ../modules/home/ghostty.nix
    #../modules/home/neovim.nix
    ../modules/home/helix.nix

     ../modules/home/hyprland.nix
     ../modules/home/wofi.nix
     ../modules/home/mako.nix
     ../modules/home/waybar.nix
     #../modules/home/swww.nix
     #../modules/home/theme-catppuccin.nix
  ];
}
