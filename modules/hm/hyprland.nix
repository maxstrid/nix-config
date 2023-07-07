{ config, pkgs, ... }:

let
  bg_path = ".config/bg.png";
in
{
  home.packages = [
    pkgs.wbg
    pkgs.grim
    pkgs.slurp
    pkgs.swayidle
    pkgs.kickoff
  ];

  home.file = {
    "${bg_path}" = {
      source = pkgs.fetchurl {
        url = "https://gitlab.com/exorcist365/wallpapers/-/raw/master/gruvbox/leaves-3.jpg";
        sha256 = "sha256-6nxLdVH6CC0kxsCG+mgTQU80/6D9NnX5XKOq69GflLs=";
      };
    };
    ".config/kickoff/config.toml" = {
      text = ''
        # Kickoff default config

        # Characters shown in front of the query.
        prompt = ""

        # space between window border and the content in pixel
        padding = 100

        fonts = [
          'JetBrainsMono NF',
        ] # list of otf or ttf fonts. later elements work as fallback
        font_size = 32.0

        [history]
        decrease_interval = 48 # interval to decrease the number of launches in hours

        [colors]
        # color format: rgb or rgba, if transparency is desired
        background = '#${config.colorScheme.colors.base00}aa'
        prompt = '#${config.colorScheme.colors.base0A}ff'
        text = '#ffffffff'          # for search results
        text_query = '#e5c07bff'    # for the search query
        text_selected = '#${config.colorScheme.colors.base0A}ff'

        [keybindings]
        # keybindings syntax: ctrl/shift/alt/logo as modifiers and a key joined by '+' signs
        # A list of available keys can be found here: https://docs.rs/crate/x11-keysymdef/0.2.0/source/src/keysym.json
        paste = ["ctrl+v"]
        execute = ["KP_Enter", "Return"]
        delete = ["KP_Delete", "Delete", "BackSpace"]
        delete_word = ["ctrl+KP_Delete", "ctrl+Delete", "ctrl+BackSpace"]
        complete = ["Tab"]
        nav_up = ["Up"]
        nav_down = ["Down"]
        exit = ["Escape"]
      '';
    };
    ".config/hypr/hyprland.conf" = {
      text = ''
        monitor=,preferred,auto,1

        exec-once = waybar & pipewire & wbg ~/${bg_path} & /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & swayidle & /usr/lib/kdeconnectd & mako
        # Execute your favorite apps at launch

        # Source a file (multi-file configs)
        # source = ~/.config/hypr/myColors.conf

        # Some default env vars.
        env = XCURSOR_SIZE,24

        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input {
        kb_layout = us,es
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
        natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }

        general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5
        gaps_out = 15
        border_size = 2
        col.active_border = rgba(${config.colorScheme.colors.base04}aa)
        col.inactive_border = rgba(${config.colorScheme.colors.base03}aa)

        layout = dwindle
        }

        decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 5
        blur = true
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = true

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
        }

        animations {
        enabled = true

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
        }

        dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true # you probably want this
        }

        master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
        }

        gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = false
        }

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        device:epic-mouse-v1 {
        sensitivity = -0.5
        }

        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, T, exec, nixGLIntel kitty
        bind = $mainMod, Q, killactive,
        bind = $mainMod, M, exit,
        bind = $mainMod, E, exec, dolphin
        bind = $mainMod, V, togglefloating,
        bind = $mainMod, P, exec, kickoff
        bind = $mainMod, L, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next 

        # Move focus with mainMod + arrow keys
        bind = $mainMod, H, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, J, movefocus, d

        bind = $mainMod SHIFT, H, movewindow, l
        bind = $mainMod SHIFT, L, movewindow, r
        bind = $mainMod SHIFT, K, movewindow, u
        bind = $mainMod SHIFT, J, movewindow, d 

        $moveAmt = 25

        bind = $mainMod ALT, H, resizeactive, -$moveAmt 0
        bind = $mainMod ALT, L, resizeactive, $moveAmt 0
        bind = $mainMod ALT, K, resizeactive, 0 -$moveAmt
        bind = $mainMod ALT, J, resizeactive, 0 $moveAmt

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # Multimedia
        bind = , XF86AudioRaiseVolume, exec, amixer set Master 5%+
        bind = , XF86AudioLowerVolume, exec, amixer set Master 5%-
        bind = , XF86AudioMute, exec, amixer set Master toggle
        bind = , XF86MonBrightnessUp, exec, sudo backlight increase
        bind = , XF86MonBrightnessDown, exec, sudo backlight decrease
        bind = , Print, exec, grim -g "$(slurp -c "#d779921")"
      '';
    };
  };
}

