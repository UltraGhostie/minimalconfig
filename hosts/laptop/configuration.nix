{ inputs, pkgs,  ... }:
{
    hardware = {
        bluetooth.enable = true;
        bluetooth.powerOnBoot = true;
    };

    home-manager.backupFileExtension = "backup";

    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs = {
        uwsm.enable = true;
        hyprland = {
            xwayland.enable = true;
            withUWSM = true;
            enable = true;
            package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; 
        };
        zsh.enable = true;
        firefox.enable = true;
    };

    services = {
        printing.enable = true;
        xserver.enable = true;
        displayManager.sddm.enable = true;
        xserver.xkb = {
            layout = "us,se";
            variant = "";
            options = "grp:ctrl_shift_toggle";
        };
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            wireplumber.enable = true;
        };
    };

    users = {
        extraGroups = {
            docker.members = [ "myUser" ];
            vboxusers.members = [ "myUser" ];
        };
        users.myUser = {
            isNormalUser = true;
            description = "Me, myself, and I";
            initialPassword = "passwd";
            extraGroups = [ "networkmanager" "wheel" ];
            shell = pkgs.zsh;
            packages = with pkgs; [
                kdePackages.kate
                #  thunderbird
            ];
        };
    };

    virtualisation = {
        virtualbox.host.enable = true;
        docker.enable = true;
    };

    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
            ../../modules/nvf
        ];


    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;


    # nixpkgs.overlays = flake-overlays;
    environment.systemPackages = with pkgs; 
            [
            networkmanagerapplet
            xwayland
            xwayland-satellite
            randombg
            hyprpaper
            hyprpolkitagent
            kitty
            gh
            pkg-config
            lsd
            bat
            ripgrep
            git
            fuzzel
            superfile
        ];


    networking = {
        hostName = "Laptix"; # Define your hostname.
        nameservers = [ "8.8.8.8" ];
        networkmanager.enable = true;
    };

    time.timeZone = "Europe/Stockholm";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "sv_SE.UTF-8";
        LC_IDENTIFICATION = "sv_SE.UTF-8";
        LC_MEASUREMENT = "sv_SE.UTF-8";
        LC_MONETARY = "sv_SE.UTF-8";
        LC_NAME = "sv_SE.UTF-8";
        LC_NUMERIC = "sv_SE.UTF-8";
        LC_PAPER = "sv_SE.UTF-8";
        LC_TELEPHONE = "sv_SE.UTF-8";
        LC_TIME = "sv_SE.UTF-8";
    };

    security.rtkit.enable = true;

    nixpkgs.config.allowUnfree = true;

    fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
    ];

    home-manager = {
        # specialArgs = { inherit inputs; };
        users = {
            "myUser" = import ./home.nix;
        };
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
