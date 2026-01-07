{ config, lib, pkgs, ... }:

let
  wallpaper = "/home/thomas/Pictures/wallpapers/wallhaven-481mj0.jpg";
in
{
  home.packages = [ pkgs.swww ];

  systemd.user.services.swww-daemon = {
    Unit.Description = "swww wallpaper daemon";
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.swww}/bin/swww img ${wallpaper}
  '';
}
