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

      /* Or adjust general font */
      * {
        font-size: 14pt; /* Adjust for global change */
      }
      window {
        border-radius: 8px;
      }
    '';
  };
}
