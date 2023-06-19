{ config, pkgs, nix-colors, ... }:

{
  home.file = {
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
  };
}
