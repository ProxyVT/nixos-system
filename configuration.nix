# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

	{ config, pkgs, ... }:
	
	let
  		unstableTarball =
    		fetchTarball
    			https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
	in

	{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];
   

# System boot section
  
	boot = {
	
		# Linux kernel version
		kernelPackages = pkgs.linuxPackages_5_15;
		 
		# Supported file systems
	  	supportedFilesystems = [ "ntfs" ];
	  	
	  	# Tmp path
	  	tmpOnTmpfs = true;
	  	
  		loader = {
	  		efi.canTouchEfiVariables = true;
	  		efi.efiSysMountPoint = "/boot/efi";
	  		timeout = 10;
  		 
	  		grub = {
	  			enable = true;
	  			version = 2; 
	  			device = "nodev";
	  			efiSupport = true;
	  			useOSProber = true;
	  			default = 2;
	  			configurationLimit = 50;
	  			splashImage = "/boot/efi/cat.png";
	  		};	
	  	};
	};

# Define your hostname.

	networking = {
		hostName = "ulad";
		interfaces.enp2s0.useDHCP = true;
		#wireless.enable = true; 
	};

# Set your time zone.

  	time = {
  		timeZone = "Europe/Istanbul";
  		hardwareClockInLocalTime = true;
  	};

# Select internationalisation properties.
  
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

# Global services configuration
  
	services = {  
		# Environment configuration	  
		xserver = {
	  		enable = true;
	  		desktopManager.pantheon.enable = true;
	  		videoDrivers = [ "nvidia" ];
	  		layout = "us,ru";
	  		libinput.enable = true; # Touchpad support
	  	};
	  	
	  	# Sound services configuration
	  	pipewire = {
    		enable = true;
    		alsa = {
    			enable = true;
    			support32Bit = true;
    		};
    	pulse.enable = true;
  		};
  		
  		# Printing services
	  	printing.enable = true;
	  	
	  	# Programms services
		deluge.enable = true;
		pantheon.apps.enable = false;
		mullvad-vpn.enable = true;
		aria2.enable = true;
		
		# Enable the OpenSSH daemon.
		openssh.enable = true;
		
		#BTRFS autoScrub
		btrfs.autoScrub.enable = true;  	
	};
	
# Global hardware configuration

	hardware = {
		# Nvidia package
		nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
		
		# Steam + Opengl
		steam-hardware.enable = true;
		opengl.enable = true;
		opengl.driSupport = true;
		opengl.driSupport32Bit = true;
		
		# Pulseaudio hardware acces
		pulseaudio.enable = false;	
	};

# Enable sound.
	sound.enable = true;
	security.rtkit.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  
	users.users.amerigo = {
		isNormalUser  = true;
		home  = "/home/amerigo";
		description  = "Amerigo";
		extraGroups  = [ "wheel" "adbusers" ];
  	};

# List packages installed in system profile. To search, run:
# $ nix search wget
  
	programs = {
    	adb.enable = true;
    	gnome-disks.enable = true;
    	pantheon-tweaks.enable = true;
    	partition-manager.enable = true;
    	steam.enable = true;
    	git.enable = true;
  	};
  
	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			unstable = import unstableTarball {
			config = config.nixpkgs.config;
			};
		};  
	};
	
	nix.autoOptimiseStore = true;
	nix.readOnlyStore = false;
  
   
  environment.systemPackages = with pkgs; [
  
  # Stable apps
  
	appimage-run
	baobab
	compsize
	deluge
	easyeffects
	eclipses.eclipse-java
	far2l
	github-desktop
	goverlay
	gpick
	guake
	hddtemp
	hdparm
	htop
	keeweb
	krita
	libreoffice-fresh
	lm_sensors
	lxqt.pcmanfm-qt
	monitor
	mullvad-vpn
	neofetch
	pavucontrol
	pantheon.elementary-files
	pantheon.elementary-screenshot
	pantheon.epiphany
	pantheon.file-roller
	qimgv
	qrcp
	s-tui
	testdisk-qt
	xclip
	wget
    
    # Unstable apps
    
	unstable.scrcpy
	unstable.yt-dlp
	unstable.pinta
	unstable.mkvtoolnix
	unstable.vivaldi
	unstable.handbrake
	unstable.tdesktop
	unstable.mpv-unwrapped
	unstable.wine-staging
	unstable.cudatext-gtk
	unstable.ventoy-bin
  ];
  
  fonts.fonts = with pkgs; [
	comic-relief
	ibm-plex
	jost
  ];
  
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
