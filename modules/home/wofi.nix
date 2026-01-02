{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    settings = {
      prompt = "Run:";
      width = "40%";
      height = "30%";
      location = "center";
    };

    style = ''
      window {
        background-color: #1e1e2e;
        border-radius: 8px;
      }
    '';
  };
}
