{ config, pkgs, lib, ... }:

{

  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

  programs.niri = {
    enable = true;


  };

}
