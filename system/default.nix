{ inputs, config, lib, pkgs, ... }:

{
        imports = [
                # Include the results of the hardware scan.
                ./hardware.nix
                # ./zsh.nix
                # ./disko
                # ./network
                # ./users
                #
                # etc ...
        ];

        # Synth program without delay
        # Ephemeral root
        # Manual neovim config (reproducible)
        # Terminal with vim keybinds. (actually usefull keybinds)
        # No mouse in terminal

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

        # Enable the Flakes feature and the accompanying new nix command-line tool
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # TODO! Research and fix randomlu occuring persistant lagg in games.
        programs.steam.enable = true;

        # List packages installed in system profile.
        # You can use https://search.nixos.org/ to find more packages (and options).
        environment.systemPackages = with pkgs; [
                # Flakes clones its dependencies through the git command,
                # so git must be installed first
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
                mona-sans
                ] ++ (with inputs.nixos-fonts.packages.x86_64-linux; [
                        anzu-moji
                        azukifont
                        rii-tegaki-fude
                ]);

        users.defaultUserShell = pkgs.zsh;

        programs.zsh.enable = true;

        programs.nvf = {
                enable = true;
                settings.vim = {
                        theme = {
                                enable = true;
                                name = "gruvbox";
                                style = "dark";
                        };

                        lsp.enable = true;

                        languages = {
                                enableTreesitter = true;

                                nix.enable = true;
                                rust.enable = true;
                                java.enable = true;
                                haskell.enable = true;
                        };

                        statusline.lualine.enable = true;
                        telescope.enable = true;
                        autocomplete.nvim-cmp.enable = true;
                };
        };

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

        services.displayManager.gdm = {
                enable = true;
        };

        services.logind.settings.Login = {
                HandleLidSwitch = "poweroff";
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


        # Define a user account. Don't forget to set a password with ‘passwd’.
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
        # console.font = "sun12x22"; # Alright, imagine a hot-reloading nix. That would be something wouldn't it.
        # Imagine if finding which fonts are available wasn't a problem. Imagine 
        # If it was an enum instead.
        # You change a single option in one file and the fucker realoads the entire
        # Systems config. That's fucking dumb. There should be a solution for this.

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        # programs.mtr.enable = true;
        # programs.gnupg.agent = {
        #   enable = true;
        #   enableSSHSupport = true;
        # };

        # List services that you want to enable:

        # Copy the NixOS configuration file and link it from the resulting system
        # (/run/current-system/configuration.nix). This is useful in case you
        # accidentally delete configuration.nix.
        # system.copySystemConfiguration = true;

        # This option defines the first version of NixOS you have installed on this particular machine,
        # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
        #
        # Most users should NEVER change this value after the initial install, for any reason,
        # even if you've upgraded your system to a new NixOS release.
        #
        # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
        # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
        # to actually do that.
        #
        # This value being lower than the current NixOS release does NOT mean your system is
        # out of date, out of support, or vulnerable.
        #
        # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
        # and migrated your data accordingly.
        #
        # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
        system.stateVersion = "25.11";
}

