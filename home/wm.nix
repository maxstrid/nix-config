{ config, pkgs, nix-colors, ... }:

# Nix config for my window manager
let 
  background_path = ".config/bg.png";
in {
  home.file = {
    ".config/bg.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ngynLk/wallpapers/master/nature/florest-stair2.jpg";
        sha256 = "sha256-VaD6gCeW2QiK405J7nzdNtv9jmmDfQeUyfkwwvWSYS8=";
      };
    };
    # Swaylock and swayidle don't play well with hm
    ".config/swaylock/config" = {
      text = ''
      image=/home/max/${background_path}
      '';
    };
    ".config/swayidle/config" = {
      text = ''
      timeout 360 "systemctl hybrid-sleep"
      before-sleep swaylock 
      lock swaylock
      '';
    };
    # TODO: Add kdeconnectd script here
    ".config/yambar/config.yml" = {
      text = ''
      brains: &brains JetBrainsMono NF:pixelsize=16
      base: &deco_base
        left-margin: 10
        right-margin: 10
        foreground: ${config.colorScheme.colors.base0A}ff
        font: *brains
        deco: {background: {color: ${config.colorScheme.colors.base00}ff}}

      bar:
        height: 16
        spacing: 0
        location: top
        layer: bottom
        background: ${config.colorScheme.colors.base00}ff

        font: *brains

        left:
          - clock:
              time-format: "󰥔 %I:%M %p"
              content:
                string:
                  <<: *deco_base
                  text: "{time}"

        right:
          - script:
              path: "/home/max/.local/bin/yambar-connect"
              content:
                map:
                  conditions:
                    paired && availible:
                      - string: {text: " Paired", on-click: "kdeconnect-app", <<: *deco_base}
                    availible:
                      - string: {text: "󰥐 Unpaired", on-click: "kdeconnect-app", <<: *deco_base}

          - network:
              name: enp0s31f6
              content:
                map:
                  conditions:
                    ~carrier: {empty: {}}
                    carrier:
                      map:
                        default: {string: {text: "󰈀  {ipv4}", <<: *deco_base}}
                        conditions:
                          state == up: {string: {text: "󰈀  {ipv4}", <<: *deco_base}}
          - network:
              name: wlan0
              content:
                map:
                  default: {string: {text: "󰤨  {ssid}", <<: *deco_base}}
                  conditions:
                    state == down:
                      - string: {text: ""}
                    state == up:
                      - string: {text: "󰤨  {ssid}", <<: *deco_base}

          - alsa:
              card: default
              mixer: Master
              content:
                map:
                  conditions:
                    muted:
                      - string: {text: "󰝟 {percent}%", <<: *deco_base}
                    ~muted:
                      - string: {text: "{percent}%", <<: *deco_base}

          - battery:
              name: BAT0
              poll-interval: 15
              anchors:
               discharging: &discharging
                 list:
                   items:
                     - ramp:
                         tag: capacity
                         items:
                           - string: {text: "󰂃 {capacity}%", <<: *deco_base, deco: {background: {color: ${config.colorScheme.colors.base08}ff}}, foreground: ${config.colorScheme.colors.base00}ff}
                           - string: {text: "󰂃 {capacity}%", <<: *deco_base, deco: {background: {color: ${config.colorScheme.colors.base08}ff}}, foreground: ${config.colorScheme.colors.base00}ff}
                           - string: {text: "󰁼 {capacity}%", <<: *deco_base}
                           - string: {text: "󰁽 {capacity}%", <<: *deco_base}
                           - string: {text: "󰁾 {capacity}%", <<: *deco_base}
                           - string: {text: "󰁿 {capacity}%", <<: *deco_base}
                           - string: {text: "󰂀 {capacity}%", <<: *deco_base}
                           - string: {text: "󰂁 {capacity}%", <<: *deco_base}
                           - string: {text: "󰂂 {capacity}%", <<: *deco_base}
                           - string: {text: "󰁹 {capacity}%", <<: *deco_base}
              content:
                map:
                  conditions:
                    state == discharging:
                      <<: *discharging
                    state == unknown:
                      <<: *discharging
                    state == "not charging":
                      <<: *discharging
                    state == full:
                      - string: {text: "󰁹 {capacity}%", <<: *deco_base}
                    state == charging:
                      string:
                        text: "󰂄 {capacity}%"
                        <<: *deco_base
                        deco: {background: {color: ${config.colorScheme.colors.base0B}ff}}
                        foreground: ${config.colorScheme.colors.base00}ff

          - battery:
              name: BAT1
              poll-interval: 15
              content:
                map:
                  conditions:
                    state == discharging:
                      <<: *discharging
                    state == unknown:
                      <<: *discharging
                    state == "not charging":
                      <<: *discharging
                    state == full:
                      - string: {text: "󰁹 {capacity}%", <<: *deco_base}
                    state == charging:
                      string:
                        text: "󰂄 {capacity}%"
                        <<: *deco_base
                        deco: {background: {color: ${config.colorScheme.colors.base0B}ff}}
                        foreground: ${config.colorScheme.colors.base00}ff
      '';
    };
    ".config/river/init" = {
      executable = true;
      text = ''
      #!/bin/sh
      riverctl map normal Super+Shift Return spawn 'eval $TERMINAL'

      # Run bemenu
      riverctl map normal Super P spawn 'bemenu-run'

      # ReInit
      riverctl map normal Super+Shift R spawn 'pkill yambar && pkill swaybg && pkill swayidle && makoctl reload && $HOME/.config/river/init'

      # Run WiFi menu
      riverctl map normal Super W spawn 'wifi'

      riverctl map normal Super E spawn 'emoji'

      # Super+Q to close the focused view
      riverctl map normal Super Q close

      riverctl map normal Super BRACKETRIGHT spawn  'river-shifttags'
      riverctl map normal Super BRACKETLEFT spawn  'river-shifttags --shift -1'

      # Super+Shift+E to exit river
      riverctl map normal Super+Shift E exit

      # Super+J and Super+K to focus the next/previous view in the layout stack
      riverctl map normal Super J focus-view next
      riverctl map normal Super K focus-view previous

      # Print screen
      riverctl map normal None Print spawn 'grim -g "$(slurp -c "#d779921")"'

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
          riverctl map $mode None XF86AudioRaiseVolume  spawn 'amixer set Master 5%+'
          riverctl map $mode None XF86AudioLowerVolume  spawn 'amixer set Master 5%-'
          riverctl map $mode None XF86AudioMute         spawn 'amixer set Master toggle'

          # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
          riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
          riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
          riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

          # Control screen backlight brightness with light (https://github.com/haikarainen/light)
          riverctl map $mode None XF86MonBrightnessUp   spawn 'sudo backlight increase'
          riverctl map $mode None XF86MonBrightnessDown spawn 'sudo backlight decrease'
      done

      # Set background and border color
      riverctl border-color-focused 0x${config.colorScheme.colors.base0A}

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
      riverctl spawn yambar
      riverctl spawn 'swaybg -i ${background_path}'
      riverctl spawn 'swayidle'
      riverctl spawn '/usr/lib/kdeconnectd'
      riverctl float-filter-add title "KDE Connect"
      [ "$(pgrep -fc river-tag-overlay)" = 0 ] && riverctl spawn 'river-tag-overlay --background-colour 0x${config.colorScheme.colors.base00} --square-active-background-colour 0x${config.colorScheme.colors.base0A} --square-active-border-colour 0x${config.colorScheme.colors.base0A} --square-active-occupied-colour 0x${config.colorScheme.colors.base01} --square-inactive-background-colour 0x${config.colorScheme.colors.base01} --square-inactive-border-colour 0x${config.colorScheme.colors.base01} --square-inactive-occupied-colour 0x${config.colorScheme.colors.base0A} --square-size 24px --square-inner-padding 7 &'
      riverctl spawn 'mako'

      rivertile -view-padding 12 -outer-padding 2 &
      '';
    };
  };

  # These services should be ran through a wm and
  # not systemd
 services.mako = {
    enable = true;
    backgroundColor = "#${config.colorScheme.colors.base00}";
    borderColor = "#${config.colorScheme.colors.base0A}";
    width = 300;
    height = 110;
    borderSize = 2;
    defaultTimeout = 15000;
    icons = false;
    ignoreTimeout = true;
  };
}
