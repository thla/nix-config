{ config, pkgs, ... }:

{

  # Keep GNOME installed, but also expose Niri as a separate Wayland session.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.niri.enable = true;
  programs.xwayland.enable = true;
  services.displayManager.sessionPackages = [ pkgs.niri ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

}
