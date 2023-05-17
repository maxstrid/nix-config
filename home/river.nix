{ config, pkgs, ... }:

let
  bgCol = "#282828";
  blankTextCol ="white";
in {
  home.packages = [
    pkgs.river
  ];

  programs.wofi = {
    enable = true;
    style = ''
      #window {
        background: ${bgCol};
        border: 2px solid #d79921;
        border-radius: 3px;
        color: ${blankTextCol};
      }

      #input {
        background: ${bgCol};
        border: 2px solid #d79921;
        border-radius: 3px;
        color: ${blankTextCol};
      }

      #entry:selected {
        background: #d79921;
        border-color: #d79921;
      }
    '';
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        spacing = 7;
        modules-left = [ "river/tags" ];
        modules-right = [ "network" "memory" "cpu" "battery#bat2" "battery" ];
        modules-center = [ "clock" ];

        "battery" = {
          bat = "BAT0";
          interval = 60;
          states = {
              warning = 30;
              critical = 15;
          };
          format-alt = "{time} {icon}";
          format =  "{capacity}% {icon}";
          format-icons = [" " " " " " " " " "];
          max-length = 25;
        };

        "battery#bat2" = {
          bat = "BAT1";
          interval = 60;
          states = {
              warning = 30;
              critical = 15;
          };
          format-alt = "{time} {icon}";
          format =  "{capacity}% {icon}";
          format-icons = [" " " " " " " " " "];
          max-length = 25;
        };

        "clock" = {
          format = "{:%I:%M %p}";
        };

        "cpu" = {
          format = "{icon} {usage}%";
          format-icons = [" "];
        };

        "memory" = {
          format = "{icon} {percentage}%";
          format-alt = "{icon} {used}/{total}";
          format-icons = [" "];
        };

        "network" = {
          format = "{ifname}";
          format-alt = "{ifname} {ipaddr}";
          format-wifi = "{essid} ({signalStrength}%) {icon}";
          format-ethernet = "{ipaddr}/{cidr} 󰈀 ";
          format-disconnected = "";
          format-icons = [ "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
        };
      };
    };
    style = ''
      window#waybar {
        background: ${bgCol};
        color: #d79921;
      }

      #tags button {
        color: #d79921;
      }

      #tags button.focused {
        background: ${bgCol};
        border-bottom: 1px solid #d79921;
        border-radius: 0;
      }

      #tags button:hover {
        background: ${bgCol};
        color: #d79921;
        border: 0;
      }

      #battery, #cpu, #memory, #network, #pulseaudio {
        border: 2px solid #d79921;
        border-radius: 5px;
        padding: 5px;
      }
    '';
  };

}
