# TODO! Encryption!
# TODO! Synth Program
# TODO! Ephemeral Root
# TODO! File for passwords (Outside of Config) (Outside of Ephemeral Root)
{ inputs, config, lib, pkgs, ... }:

{
        imports = [
                ./hardware.nix # TODO! Remove this file from git repo
                # ./zsh.nix
                # ./disko
                # ./network
                # ./users
                #
                # etc ...
        ];

        nixpkgs.config.allowUnfree = true;
        hardware.bluetooth = {
                enable = true;
                settings = {
                        General = {
                                FastConnectable = true;
                        };
                        Policy = {
                                AutoEnable = true;
                        };
                };
        };

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # TODO! Fix random persistant lag
        programs.steam.enable = true;

        # You can use https://search.nixos.org/ to find more packages (and options).
        environment.systemPackages = with pkgs; [
                # nvcat # ^^
                neovim
                prismlauncher
                heroic
                pavucontrol
                pamixer
                spotify
                r2modman
                anki
                git
                mpv
                mupdf
                tree
                grim
                slurp
                wl-clipboard
                mariadb-connector-java
                jdk25_headless
                maven
                discord
                slack
                android-studio
                libnotify
                firefox
                brightnessctl
                inputs.swaymonad.defaultPackage.x86_64-linux
        ];
                                                        

        fonts.packages = with pkgs; [
                comic-mono
                mona-sans
                ] ++ (with inputs.nixos-fonts.packages.x86_64-linux; [
                        anzu-moji
                        azukifont
                        rii-tegaki-fude
                ]);

        users.defaultUserShell = pkgs.zsh;

        programs.zsh.enable = true;

        # Set the default editor to neovim
        environment.variables = {
                EDITOR = "nvim";
                NIX_SHELL ="zsh";
        };

        # Use the systemd-boot EFI boot loader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "lini"; # Define your hostname.

        # Configure network connections interactively with nmcli or nmtui.
        networking.networkmanager.enable = true;

        # Set your time zone.
        time.timeZone = "Europe/Stockholm";

        services.plantuml-server.enable = true;
        # CUPS
        services.printing.enable = true;
        # Sound
        services.pipewire = {
                enable = true;
                pulse.enable = true;
        };
        # Enable the OpenSSH daemon.
        services.openssh.enable = true;

        services.mysql = {
                enable = true;
                package = pkgs.mariadb;
        };

        services.tlp = {
                enable = true;
                settings = {
                        CPU_SCALING_GOVERNOR_ON_AC = "performance";
                        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

                        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
                        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

                        CPU_MIN_PERF_ON_AC = 0;
                        CPU_MAX_PERF_ON_AC = 100;
                        CPU_MIN_PERF_ON_BAT = 0;
                        CPU_MAX_PERF_ON_BAT = 20;

                        # Optional helps save long term battery health
                        # TODO! fix this, it does not fucking work. fucking Bitchass.
                        START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
                        STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
                };
        };

        services.auto-cpufreq = {
                enable = true;
                settings = {
                        battery = {
                                governor = "powersave";
                                turbo = "never";
                        };
                        charger = {
                                governor = "performance";
                                turbo = "auto";
                        };
                };
        };

        services.getty = {
                autologinUser = "lini";
                autologinOnce = true;
        };
        environment.loginShellInit = ''
                [[ "$(tty)" == /dev/tty1 ]] && sway
        '';

        services.logind.settings.Login = {
                HandleLidSwitch = "swaylock";
                HandleLidSwitchExternalPower = "lock";
                HandleLidSwitchDocked = "ignore";
        };

        i18n.inputMethod = {
                type = "fcitx5";
                enable = true;
                # waylandFrontend = true;
                fcitx5.addons = with pkgs; [
                        fcitx5-mozc
                ];
        };


        users.users.lini = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
                shell = pkgs.zsh;
                packages = with pkgs; [
                        tree
                        qutebrowser
                ];
        };

        programs.sway.enable = true;

        networking.firewall.enable = false;

        # Doesn't work I dunno why
        # console.font = "sun12x22";
        # Ponera Enum Istället för strängar. 

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        # programs.mtr.enable = true;
        # programs.gnupg.agent = {
        #   enable = true;
        #   enableSSHSupport = true;
        # };

        # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
        # DO NOT CHANGE!!!
        system.stateVersion = "25.11";
}

