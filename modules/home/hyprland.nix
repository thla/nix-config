{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # -------------------------
      # MONITORS
      # -------------------------
      monitor = [
        "eDP-1,1920x1080@60,0x0,1.25"
      ];

      # -------------------------
      # GENERAL LOOK & FEEL
      # -------------------------
      general = {
        gaps_in = 6;
        gaps_out = 12;
        border_size = 3;
        "col.active_border" = "rgb(89b4fa)";
        "col.inactive_border" = "rgb(313244)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
        };
        #drop_shadow = true;
        #shadow_range = 20;
        #shadow_render_power = 3;
        #"col.shadow" = "rgba(00000055)";
      };

      animations = {
        enabled = true;
        bezier = [
          "ease, 0.05, 0.9, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 7, ease"
          "windowsOut, 1, 7, ease"
          "border, 1, 10, ease"
          "fade, 1, 7, ease"
          "workspaces, 1, 6, ease"
        ];
      };

      # -------------------------
      # INPUT
      # -------------------------
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
      };

      # -------------------------
      # KEYBINDS
      # -------------------------
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, alacritty"
        "$mod, D, exec, wofi --show drun"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"
        "$mod, R, exec, swww img $WALLPAPER"
        "$mod SHIFT, E, exit"

      # Move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

      # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

      # Move windows to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
      ];

      # -------------------------
      # AUTOSTART
      # -------------------------
      exec-once = [
        "waybar"
        "mako"
        "swww-daemon"
        "swww img $WALLPAPER"
      ];
    };
  };
}
