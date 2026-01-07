{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    # ghostty is available in nixpkgs, so this installs the binary as well
    package = pkgs.ghostty;

    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;

      theme = "Catppuccin Mocha";

      #window_decoration = false;
      #window-padding-x = 8;
      #window-padding-y = 8;

      #cursor-style = "bar";
      #cursor-style-blink = true;

      background-opacity = 0.95;

      # Example keybinding
      keybind = [
        "ctrl+shift+t=new_tab"
        "ctrl+shift+w=close_tab"
      ];
    };
  };
}
