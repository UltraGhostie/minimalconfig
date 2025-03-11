{
    wayland.windowManager ={
        hyprland.systemd.enable = false;
        hyprland.settings = {
            "$mod" = "SUPER";
            monitor = ",preferred,auto,1";
            "$terminal" = "kitty";
            "$menu" = "fuzzel";
            "$filemanager" = "superfile";

            exec-once = [
                "swaync"
                "waybar"
                "hyprpaper"
                "xwayland-satellite"
            ];

            decoration = {
                rounding = 10;
                rounding_power = 2;

                # Change transparency of focused and unfocused windows
                active_opacity = 1.0;
                inactive_opacity = 1.0;

                shadow = {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                };

                # https://wiki.hyprland.org/Configuring/Variables/#blur
                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;

                    vibrancy = 0.1696;
                };
            };

            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };

            input = {
                kb_layout = "us";

                follow_mouse = 1;

                sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

                touchpad = {
                    natural_scroll = true;
                };
            };
            gestures = {
                workspace_swipe = true;
                workspace_swipe_fingers = 4;
            };

            master = {
                new_status = "master";
            };

            animations = {
                enabled = true;

                # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = [
                    "easeOutQuint,0.23,1,0.32,1"
                    "easeInOutCubic,0.65,0.05,0.36,1"
                    "linear,0,0,1,1"
                    "almostLinear,0.5,0.5,0.75,1.0"
                    "quick,0.15,0,0.1,1"
                ];

                animation = [
                    "global, 1, 10, default"
                    "border, 1, 5.39, easeOutQuint"
                    "windows, 1, 4.79, easeOutQuint"
                    "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                    "windowsOut, 1, 1.49, linear, popin 87%"
                    "fadeIn, 1, 1.73, almostLinear"
                    "fadeOut, 1, 1.46, almostLinear"
                    "fade, 1, 3.03, quick"
                    "layers, 1, 3.81, easeOutQuint"
                    "layersIn, 1, 4, easeOutQuint, fade"
                    "layersOut, 1, 1.5, linear, fade"
                    "fadeLayersIn, 1, 1.79, almostLinear"
                    "fadeLayersOut, 1, 1.39, almostLinear"
                    "workspaces, 1, 1.94, almostLinear, fade"
                    "workspacesIn, 1, 1.21, almostLinear, fade"
                    "workspacesOut, 1, 1.94, almostLinear, fade"
                ];
            };

            bind = [
                "$mod, F, exec, firefox"
                ", Print, exec, grimblast copy area"
                "$mod, T, exec, $terminal"
                "$mod, C, killactive,"
                "$mod, M, exit,"
                "$mod, E, exec, $terminal $fileManager"
                "$mod, V, togglefloating,"
                "$mod, R, exec, $menu"
                "$mod, P, pseudo,"
                "$mod, B, exec, randombg"
                "$mod, S, togglesplit,"
                "$mod, J, movefocus, l"
                "$mod, SEMICOLON, movefocus, r"
                "$mod, k, movefocus, u"
                "$mod, j, movefocus, d"
            ]
                ++ (
                    builtins.concatLists (builtins.genList (i:
                        let ws = i + 1;
                        in
                            [
                            "$mod, code:1${toString i}, workspace, ${toString ws}"
                            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                        ]
                    )
                        9)
                );
            bindm = [

                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
            ];

            bindel = [
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ];

            bindl = [
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPrev, exec, playerctl previous"
            ];

            windowrulev2 = [
                "suppressevent maximize, class:.*"
                "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            ];
        };
    };
}
