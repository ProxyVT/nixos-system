# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 10;
  boot.plymouth.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "btrfs" "ntfs" "ext4" "exfat" ];
  

  networking.hostName = "powehi"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  

  # Set your time zone.
  time.timeZone = "Europe/Minsk";
  time.hardwareClockInLocalTime = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system and Pantheon Desktop Environment.
  services.xserver.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;
  services.xserver.windowManager.i3.enable = false;
  services.xserver.displayManager.defaultSession = "pantheon";

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.powehi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

	# System apps
    vim
    wget
    neofetch
    monitor
    geany
    nnn
    far2l
    appimage-run
    gparted
    pantheon.sideload
    papirus-icon-theme
    lite-xl
    testdisk
    baobab
    hwinfo
    
    # Security
    tor
    keeweb
    clamav
    
    # Work   
    eclipses.eclipse-java
    libreoffice-fresh
    github-desktop
    
    # Games
    razergenie
    
    # Internet
    vivaldi
    tdesktop
    # tor-browser-bundle-bin
    transmission-gtk
    
    # Media
    mpv-unwrapped
    yt-dlp
    krita
    pinta
    qimgv
    mkvtoolnix
    handbrake
    scrcpy
    
  ];
  
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  programs.pantheon-tweaks.enable = true;
  programs.partition-manager.enable = true;
  programs.gnome-disks.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "wheel" ];
  
  qt5 = {
    enable = true;
    platformTheme = "gnome";
  };
  
  services = {
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

