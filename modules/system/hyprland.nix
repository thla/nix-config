{ config, pkgs, inputs, ... }:

{
  #imports = [inputs.hyprland.nixosModules.default];

  programs.hyprland.enable = true;

  #services.xserver.enable = false;
  #services.displayManager.sddm.enable = false;

  hardware.opengl.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    wayland
    wl-clipboard
    grim slurp
    wofi
    mako
  ];
}
