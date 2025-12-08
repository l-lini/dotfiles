{ config, lib, pkgs, nvf, ... }:

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

        nixpkgs.config.allowUnfree =true;

        # Enable the Flakes feature and the accompanying new nix command-line tool
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # List packages installed in system profile.
        # You can use https://search.nixos.org/ to find more packages (and options).
        environment.systemPackages = with pkgs; [
                # Flakes clones its dependencies through the git command,
                # so git must be installed first
                git
                tree
                grim
                slurp
                wl-clipboard
                mako
                mariadb-connector-java
                jdk25_headless
                maven
                discord
                slack
                android-studio
        ];

        fonts.packages = with pkgs; [
                mona-sans
        ];

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

                        # lsp.enable = true;

                        languages = {
                                enableTreesitter = true;
                                enableLSP = true;

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
        environment.variables.EDITOR = "nvim";

        # Use the systemd-boot EFI boot loader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "lini"; # Define your hostname.

        # Configure network connections interactively with nmcli or nmtui.
        networking.networkmanager.enable = true;

        # Set your time zone.
        time.timeZone = "Europe/Stockholm";

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


        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.lini = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
                packages = with pkgs; [
                        tree
                        qutebrowser
                ];
        };

        programs.sway.enable = true;

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

