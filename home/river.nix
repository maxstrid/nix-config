{ config, pkgs, ... }:

let
  bgCol = "#282828";
  blankTextCol ="white";
in {
  home.packages = [
    pkgs.wbg
    pkgs.river
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-BL";
      package = pkgs.gruvbox-gtk-theme;
    };
  };

  home.file = {
    ".config/river/bg.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/lunik1/nixos-logo-gruvbox-wallpaper/master/png/gruvbox-dark-rainbow.png";
        sha256 = "sha256-7CMuETntiVUCKhUIdJzX+sf3F47GvuX2a61o4xbEzww=";
      };
    };

    ".config/river/init" = {
      executable = true;
      text = ''
        #!/bin/sh

        riverctl map normal Super+Shift Return spawn kitty

        # Run wofi
        riverctl map normal Super P spawn 'wofi --show drun'

        # Super+Q to close the focused view
        riverctl map normal Super Q close

        # Super+Shift+E to exit river
        riverctl map normal Super+Shift E exit

        # Super+J and Super+K to focus the next/previous view in the layout stack
        riverctl map normal Super J focus-view next
        riverctl map normal Super K focus-view previous

        # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
        # view in the layout stack
        riverctl map normal Super+Shift J swap next
        riverctl map normal Super+Shift K swap previous

        # Super+Period and Super+Comma to focus the next/previous output
        riverctl map normal Super Period focus-output next
        riverctl map normal Super Comma focus-output previous

        # Super+Shift+{Period,Comma} to send the focused view to the next/previous output
        riverctl map normal Super+Shift Period send-to-output next
        riverctl map normal Super+Shift Comma send-to-output previous

        # Super+Return to bump the focused view to the top of the layout stack
        riverctl map normal Super Return zoom

        # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
        riverctl map normal Super H send-layout-cmd rivertile "main-ratio -0.05"
        riverctl map normal Super L send-layout-cmd rivertile "main-ratio +0.05"

        # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
        riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
        riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"

        # Super+Alt+{H,J,K,L} to move views
        riverctl map normal Super+Alt H move left 100
        riverctl map normal Super+Alt J move down 100
        riverctl map normal Super+Alt K move up 100
        riverctl map normal Super+Alt L move right 100

        # Super+Alt+Control+{H,J,K,L} to snap views to screen edges
        riverctl map normal Super+Alt+Control H snap left
        riverctl map normal Super+Alt+Control J snap down
        riverctl map normal Super+Alt+Control K snap up
        riverctl map normal Super+Alt+Control L snap right

        # Super+Alt+Shift+{H,J,K,L} to resize views
        riverctl map normal Super+Alt+Shift H resize horizontal -100
        riverctl map normal Super+Alt+Shift J resize vertical 100
        riverctl map normal Super+Alt+Shift K resize vertical -100
        riverctl map normal Super+Alt+Shift L resize horizontal 100

        # Super + Left Mouse Button to move views
        riverctl map-pointer normal Super BTN_LEFT move-view

        # Super + Right Mouse Button to resize views
        riverctl map-pointer normal Super BTN_RIGHT resize-view

        # Super + Middle Mouse Button to toggle float
        riverctl map-pointer normal Super BTN_MIDDLE toggle-float

        for i in $(seq 1 9)
        do
            tags=$((1 << ($i - 1)))

            # Super+[1-9] to focus tag [0-8]
            riverctl map normal Super $i set-focused-tags $tags

            # Super+Shift+[1-9] to tag focused view with tag [0-8]
            riverctl map normal Super+Shift $i set-view-tags $tags

            # Super+Control+[1-9] to toggle focus of tag [0-8]
            riverctl map normal Super+Control $i toggle-focused-tags $tags

            # Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
            riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
        done

        # Super+0 to focus all tags
        # Super+Shift+0 to tag focused view with all tags
        all_tags=$(((1 << 32) - 1))
        riverctl map normal Super 0 set-focused-tags $all_tags
        riverctl map normal Super+Shift 0 set-view-tags $all_tags

        # Super+Space to toggle float
        riverctl map normal Super Space toggle-float

        # Super+F to toggle fullscreen
        riverctl map normal Super F toggle-fullscreen

        # Super+{Up,Right,Down,Left} to change layout orientation
        riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
        riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
        riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
        riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

        # Declare a passthrough mode. This mode has only a single mapping to return to
        # normal mode. This makes it useful for testing a nested wayland compositor
        riverctl declare-mode passthrough

        # Super+F11 to enter passthrough mode
        riverctl map normal Super F11 enter-mode passthrough

        # Super+F11 to return to normal mode
        riverctl map passthrough Super F11 enter-mode normal

        # Various media key mapping examples for both normal and locked mode which do
        # not have a modifier
        for mode in normal locked
        do
            # Eject the optical drive (well if you still have one that is)
            riverctl map $mode None XF86Eject spawn 'eject -T'

            # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
            riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
            riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
            riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

            # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
            riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
            riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
            riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
            riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

            # Control screen backlight brightness with light (https://github.com/haikarainen/light)
            riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
            riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'
        done

        # Set background and border color
        riverctl background-color 0x282828
        riverctl border-color-focused 0xd79921
        riverctl border-color-unfocused 0x875e0f

        # Set keyboard repeat rate
        riverctl set-repeat 50 300

        # Make all views with an app-id that starts with "float" and title "foo" start floating.
        riverctl rule-add float -app-id 'float*' -title 'foo'

        # Make all views with app-id "bar" and any title use client-side decorations
        riverctl rule-add csd -app-id "bar"

        # Set the default layout generator to be rivertile and start it.
        # River will send the process group of the init executable SIGTERM on exit.
        riverctl default-layout rivertile
        riverctl spawn waybar
        riverctl spawn 'wbg $HOME/.config/river/bg.png'
        rivertile -view-padding 6 -outer-padding 6 &
      '';
    };
  };

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
              critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-critical = "󰂃 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["󱉞 " "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        "battery#bat2" = {
          bat = "BAT1";
          interval = 60;
          states = {
              critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-critical = "󰂃 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["󱉞 " "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
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

      .modules-right {
        border: 2px solid #d79921;
        border-radius: 5px;
        padding: 5px;
      }
    '';
  };

}
