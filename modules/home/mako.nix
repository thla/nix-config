{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    borderSize = 2;
    defaultTimeout = 5000;
    font = "JetBrainsMono 11";
  };
}
