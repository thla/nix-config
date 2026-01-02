{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 42;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "battery" "network" ];

        # Volume Module (using PulseAudio/PipeWire)
        pulseaudio = {
          format = "{volume}% {icon}  ";
          format-muted = " Muted";
          format-icons = {
            headphone = "";
            default = ["" ""];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        # Network Module
        network = {
          format-wifi = "{essid} ({signalStrength}%)    ";
          format-ethernet = "{ipaddr}/{cidr}   ";
          format-disconnected = "Disconnected ⚠";
          tooltip-format = "{ifname} via {gwaddr}   ";
        };

        # Battery Module
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}  ";
          format-charging = "{capacity}%  ";
          format-plugged = "{capacity}% ";
          format-icons = ["" "" "" "" ""];
        };



        clock = {
          format = "{:%Y-%m-%d %H:%M}";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
        };
      };
    };

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 16px;
        color: #cdd6f4;
      }

      window#waybar {
        background: #1e1e2e;
        border-bottom: 2px solid #89b4fa;
      }
    '';
  };
}
