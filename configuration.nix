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
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.timeout = 10;
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2; 
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.default = 2;
  boot.loader.grub.configurationLimit = 100;
  boot.loader.grub.splashImage = "/boot/efi/cat.png";
  
  

  networking.hostName = "ulad"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";
  time.hardwareClockInLocalTime = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;

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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
	nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
	steam-hardware.enable = true;
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  
  users.users.amerigo = {
	isNormalUser  = true;
	home  = "/home/amerigo";
	description  = "Amerigo";
	extraGroups  = [ "wheel" "networkmanager" "adbusers" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  programs = {
    adb.enable = true;
    gnome-disks.enable = true;
    pantheon-tweaks.enable = true;
    partition-manager.enable = true;
    steam.enable = true;
    java.enable = true;
    git.enable = true;
  };
  
  nixpkgs.config = {
	allowUnfree = true;
	packageOverrides = pkgs: {
    unstable = import <nixpkgs-unstable> {
	  config = config.nixpkgs.config;
	  };
	};
  };
  
   
  environment.systemPackages = with pkgs; [
  
	appimage-run
	baobab
	clamav
	deluge
	eclipses.eclipse-java
	far2l
	github-desktop
	gcolor2
	goverlay
	gpick
	guake
	hddtemp
	htop
#	index-fm
	keeweb
	libreoffice-fresh
	lite-xl
	lm_sensors
	monitor
	mullvad-vpn
	neofetch
	nnn
	pavucontrol
	pantheon.elementary-files
	pantheon.elementary-screenshot
	qdirstat
	qimgv
	qrcp
	s-tui
	testdisk-qt
	ventoy-bin
	vlc
	wget
    
	unstable.scrcpy
	unstable.yt-dlp
	unstable.pinta
	unstable.krita
	unstable.mkvtoolnix
	unstable.vivaldi
	unstable.handbrake
	unstable.tdesktop
	unstable.mpv-unwrapped
	unstable.wine-staging
	unstable.vscodium-fhs
	
    
  ];
  
  fonts.fonts = with pkgs; [
	comic-relief
	ibm-plex
	jost
  ];
  
  services = {
	deluge.enable = true;
	pantheon.apps.enable = false;
	mullvad-vpn.enable = true;
	aria2.enable = true;
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
  
  hardware = {
	opengl.enable = true;
	opengl.driSupport = true;
	opengl.driSupport32Bit = true;
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

