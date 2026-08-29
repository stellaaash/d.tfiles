# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:
{
  # Use Lix with an overlay so external tools can access it too
  nixpkgs.overlays = [ (final: prev: {
    inherit (prev.lixPackageSets.stable)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./goldalice.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "himalayan-blue-poppy"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Hostname for my home server
  networking.extraHosts =
    ''
      192.168.1.33     flowering-raspberry
      192.168.1.33     n8n.stellaaa.sh
    '';

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = ["fr_CH.UTF-8/UTF-8"];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Keyboard layouts
  services.xserver.xkb = {
    layout = "us,ch";     # primary then secondary
    variant = ",fr";  # variants match layouts by index
    options = "grp:alt_shift_toggle"; # switch with Alt+Shift (choose another if preferred)
  };
  console.useXkbConfig = true;  # TTY console follows the xkb config


  # Gaming stuff (here because Steam can't be installed through home-manager)
  programs.gamemode.enable = true;
  ## Steam
  programs.steam = {
    enable = true;
  };
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stellaaash = {
    isNormalUser = true;
    description = "Aisling Fontaine";
    extraGroups = [ "networkmanager" "wheel" "dialout" "docker" ];
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)
    user = "stellaaash";
    dataDir = "/home/stellaaash/Documents";
  };

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  # Tailscale
  services.tailscale = {
    enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nvidia drivers
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     lsd
     git
     curl
     wget
     openssh
     bash
     fish
     wooting-udev-rules
     wootility
     flow-control
     # Helix from master (see flake input): release 25.07.1 lacks LSP pull
     # diagnostics, which the current vscode-eslint-language-server requires.
     inputs.helix.packages.${pkgs.system}.default
     man-pages
     man-pages-posix
     nixd
     nil
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd";
      ll = "ls -lArth";
    };
  };
  users.defaultUserShell = pkgs.fish;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
