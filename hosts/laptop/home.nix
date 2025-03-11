{ config, inputs, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.

    imports = [
        ./hyprland.nix
    ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.

    home = {
        stateVersion = "24.05"; # Please read the comment before changing.
        username = "myUser";
        homeDirectory = "/home/myUser";
        sessionVariables = {
            EDITOR = "nvim";
        };
    };

    accounts.calendar.basePath = ./Calendars;

    programs = {
        oh-my-posh.enable = true;
        oh-my-posh.enableZshIntegration = true;
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            history = {
                append = true;
                ignoreAllDups = true;
            };
            syntaxHighlighting = {
                enable = true;
            };
            plugins = [
                {
                    name = "fzf-tab";
                    src = pkgs.fetchFromGitHub {
                        owner = "Aloxaf";
                        repo = "fzf-tab";
                        hash = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
                        rev = "v1.1.2";
                    };
                }
            ];
            initExtra = ''
            eval "$(oh-my-posh init zsh --config $HOME/.config/nixos/modules/ohmyposh/zen.toml)"
            autoload -U compinit 
            compinit
            source /nix/store/sdzigpp8l9phmk7zjhc8dgfnd95g0n5g-source/fzf-tab.plugin.zsh
            eval "$(zoxide init --cmd cd zsh)"
            [[ ! -r '/home/myUser/.opam/opam-init/init.zsh' ]] || source '/home/myUser/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
            '';
        };
        lazygit.enable = true;
        zoxide.enable = true;
        git = {
            enable = true;
            userName = "My User";
            userEmail = "my.user@service.com";
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };

        waybar = {
            enable = true;
            settings = {

                main-bar = {
                    position = "top";
                    layer = "top";
                    height = 30;
                    margin-top = 6;
                    margin-left = 10;
                    margin-right = 10;
                    spacing = 5;

                    modules-left = [
                        "hyprland/workspaces"
                    ];

                    modules-center = [
                        "clock"
                    ];

                    modules-right = [
                        "idle_inhibitor"
                        "pulseaudio"
                        "network"
                        "cpu"
                        "memory"
                        "temperature"
                        "backlight"
                        "battery"
                        "tray"
                        "custom/power"
                    ];

                    "hyprland/workspaces" = {
                        disable-scroll = true;
                        all-outputs = true;
                        format = "{icon}";
                        format-icons = {
                            "1" = "󰋜";
                            "2" = "";
                            "3" = "";
                            "4" = "󰙯";
                            "5" = "󰎄";
                            "6" = "󰎆";
                            "7" = "󰎇";
                            "8" = "󰎉";
                            "9" = "󰎋";
                            "10" = "󰎍";
                            urgent = "󰗖";
                            focused = "󰗖";
                            default = "󰋔";
                        };
                    };

                    "hyprland/submap" = {
                        format = "<span style=\"italic\">{}</span>";
                    };

                    idle_inhibitor = {
                        format = "{icon}";
                        format-icons = {
                            activated = "󰅶";
                            deactivated = "󰾪";
                        };
                        tooltip = true;
                        tooltip-format-activated = "Idle Inhibitor Active";
                        tooltip-format-deactivated = "Idle Inhibitor Inactive";
                    };

                    tray = {
                        icon-size = 18;
                        spacing = 1;
                    };

                    clock = {
                        format = "{:%I:%M %p}";
                        format-alt = "{:%Y-%m-%d | %I:%M %p}";
                        tooltip-format = "<big>{:%B %Y}</big>\n<tt>{calendar}</tt>";
                        calendar = {
                            mode = "month";
                            weeks-pos = "right";
                            on-scroll = 1;
                            format = {
                                months = "<span color='#268bd2'>{}</span>";
                                days = "<span color='#93a1a1'>{}</span>";
                                weeks = "<span color='#cb4b16'>{}</span>";
                                weekdays = "<span color='#2aa198'>{}</span>";
                                today = "<span color='#d33682'><b>{}</b></span>";
                            };
                        };
                        actions = {
                            on-click = "mode";
                            on-click-right = "tz_list";
                        };
                    };

                    cpu = {
                        format = "󰘚 {usage}%";
                        tooltip = true;
                        interval = 2;
                    };

                    memory = {
                        format = "󰍛 {percentage}%";
                        tooltip = true;
                        tooltip-format = "RAM: {used:0.1f}GiB/{total:0.1f}GiB";
                        interval = 3;
                    };

                    temperature = {
                        critical-threshold = 80;
                        format = "{icon} {temperatureC}°C";
                        format-icons = ["󰔏" "󰔐" "󱃂"];
                        tooltip = true;
                    };

                    backlight = {
                        format = "{icon} {percent}%";
                        format-icons = ["󰃞" "󰃟" "󰃠"];
                        on-scroll-up = "light -A 5";
                        on-scroll-down = "light -U 5";
                    };

                    battery = {
                        states = {
                            good = 80;
                            warning = 30;
                            critical = 10;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = "󰂄 {capacity}%";
                        format-plugged = "󰚥 {capacity}%";
                        format-alt = "{time} {icon}";
                        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                    };

                    network = {
                        format-wifi = "󰤨 {essid}";
                        format-ethernet = "󰈀 {ipaddr}/{cidr}";
                        format-disconnected = "󰤮 Disconnected";
                        tooltip-format = "{ifname}: {ipaddr}/{cidr}\n󰤨 {essid} ({signalStrength}%)\n󱘖 {bandwidthUpBits}\n󱘒 {bandwidthDownBits}";
                        on-click = "nm-connection-editor";
                    };

                    pulseaudio = {
                        format = "{icon} {volume}%";
                        format-muted = "󰝟 Muted";
                        format-icons = {
                            headphone = "󰋋";
                            hands-free = "󰋎";
                            headset = "󰋎";
                            phone = "󰏲";
                            portable = "󰄝";
                            car = "󰄋";
                            default = ["󰕿" "󰖀" "󰕾"];
                        };
                        on-click = "pavucontrol";
                        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
                        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
                    };

                    "custom/media" = {
                        format = "🎵 {}";
                        # exec = "$HOME/arkscripts/player.sh";
                        return-type = "json";
                        signal = 10;
                        on-click = "playerctl play-pause";
                        on-scroll-up = "playerctl next";
                        on-scroll-down = "playerctl previous";
                    };

                    "custom/power" = {
                        format = "󰐥";
                        on-click = "wlogout";
                        tooltip = false;
                    };
                };
            };
        };
    };

    qt.enable = true;

    home.shellAliases = {
        matlab = "nix run gitlab:doronbehar/nix-matlab";
        cd = "__zoxide_z";
        cdi = "__zoxide_zi";
        v = "nvim .";
        ls = "lsd";
        la = "lsd -a";
        g = "git";
        ga = "git add";
        gaa = "git add -A";
        gc = "git commit";
        gca = "git commit -a";
        gcam = "git commit -a -m";
        gp = "git push";
        gl = "git pull";
        glg = "git log --stat";
        glgg = "git log --graph";
        glgga = "git log --graph --decorate --all";
        glgm = "git log --graph --max-count=10";
        glgp = "git log --graph --patch";
        glo = "git log --oneline --decorate";
        glog = "git log --oneline --decorate --graph";
        gloga = "git log --oneline --decorate --graph --all";
        gco = "git checkout";
        gb = "git branch";
        gst = "git status";
        gss = "git status --short";
        gsps = "git show --pretty=short --show-signature";
        gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
        gd = "git diff";
        lg = "lazygit";
        uzip = "ripunzip";
        nixc = "nvim ~/.config/nixos/";
        rb = "sudo nixos-rebuild switch --flake ~/.config/nixos#laptop --cores 0";
        test = "sudo nixos-rebuild test --flake ~/.config/nixos#laptop --cores 0";
        garbage = "sudo nix-collect-garbage -d";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
