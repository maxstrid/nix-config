{ config, ... }:

{
  # Experimental for wlr/workspaces
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;

        modules-left = [ "hyprland/language" "clock" "network" ];
        modules-center = [ "wlr/workspaces" ];
        modules-right = [ "pulseaudio" "battery#bat2" "battery" ];

        "wlr/workspaces" = {
          persistent_workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
          };
        };

        "battery" = {
          bat = "BAT0";
          interval = 10;
          states = {
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "  {capacity}%";
          format-critical = "󰂃 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };

        "battery#bat2" = {
          bat = "BAT1";
          interval = 10;
          states = {
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "  {capacity}%";
          format-critical = "󰂃 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };

        "clock" = {
          format = "{:%I:%M %p}";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {volume}%";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
        "network" = {
          format = "{ifname}";
          format-alt = "{ifname} {ipaddr}";
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰈀  {ipaddr}/{cidr}";
          format-disconnected = "";
          format-icons = [ "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
        };
      };
    };
    style = ''
      window#waybar {
        background-color: rgba(40, 40, 40, 0);
        padding: 0;
        margin: 0;
        font-family: JetBrainsMono NF; 
        font-size: 12px;
        font-weight: bold;
      }

      #workspaces {
        background-color: #${config.colorScheme.colors.base01};
        color: #${config.colorScheme.colors.base04};
        border: 2px solid #${config.colorScheme.colors.base04};
        padding: 0px;
        margin: 2px;
        border-radius: 5px;
      }

      #workspaces button {
        color: #${config.colorScheme.colors.base04};

        padding-top: 0px;
        padding-bottom: 0px;
        padding-left: 5px;
        padding-right: 5px;

        margin-left: 6px;
        margin-right: 6px;
        margin-top: 1px;
        margin-bottom: 1px;
      }

      #workspaces button.active {
        color: #${config.colorScheme.colors.base01};
        background-color: #${config.colorScheme.colors.base04};
      }

      #battery, #clock, #pulseaudio, #network, #language {
        background-color: #${config.colorScheme.colors.base01};
        color: #${config.colorScheme.colors.base04};
        border: 2px solid #${config.colorScheme.colors.base04};

        padding-top: 0px;
        padding-bottom: 0px;
        padding-left: 6px;
        padding-right: 6px;

        margin-left: 6px;
        margin-right: 6px;
        margin-top: 1px;
        margin-bottom: 1px;

        border-radius: 5px;
      }

      #battery.critical {
        color: #${config.colorScheme.colors.base08};
      }

      #battery.charging {
        color: #${config.colorScheme.colors.base0B};
      }
    '';
  };


}
