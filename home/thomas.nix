{ config, pkgs, ... }:

{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "26.05";

  imports = [
    ../modules/home/shell.nix
    ../modules/home/git.nix
    ../modules/home/programs.nix
    ../modules/home/ghostty.nix
    ../modules/home/neovim.nix
    ../modules/home/niri.nix
  ];
}
