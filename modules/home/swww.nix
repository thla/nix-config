{ config, pkgs, ... }:

{
  home.packages = [ pkgs.swww ];

  systemd.user.services.swww-daemon = {
    Unit = {
      Description = "Swww wallpaper daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.sessionVariables = {
    WALLPAPER = "/home/thomas/Pictures/wallpapers/catppuccin-mocha.png";
  };

  home.activation.setWallpaper = ''
    ${pkgs.swww}/bin/swww img "$WALLPAPER" --transition-type grow --transition-step 90
  '';
}
