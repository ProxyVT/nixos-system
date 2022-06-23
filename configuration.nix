# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

	{ config, pkgs, lib, ... }:
	
	let
  		unstable = import <unstable> { config =
  		 	{ 
  		 		allowUnfree = true; 
  		 	}; 
  		};
	in

	{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];
   
# System boot section
  
	boot = {
	
		# Linux kernel version
		#kernelPackages = pkgs.linuxPackages_5_15;
		kernelPackages = pkgs.linuxPackages_xanmod_latest;
		 
		# Supported file systems
	  	supportedFilesystems = [ "ntfs" ];
	  	
	  	# Systemd-boot loader config
  		loader = {
	  		timeout = 5;
	  		systemd-boot.enable = true;
	  		efi.canTouchEfiVariables = true;
	  	};
	};

# Define your hostname.

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

# Set your time zone.

  	time = {
  		timeZone = "Europe/Istanbul";
  	};

# Select internationalisation properties.
  
	i18n.defaultLocale = "C"; 
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

# Global services configuration
  
	services = {  
		# Environment configuration	  
		xserver = {
	  		enable = true;
	  		desktopManager.plasma5 = {
	  			enable = true;
	  			supportDDC = true;
	  		};
	  		displayManager.sddm = {
        		enable = true;
        		autoNumlock = true;
      		};
	  		layout = "us,ru";
	  		xkbOptions = "grp:win_space_toggle";
	  		
	  		# Touchpad support
	  		libinput.enable = true;
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
		mullvad-vpn.enable = true;
		aria2.enable = true;
		
		# Enable the OpenSSH daemon.
		openssh.enable = true;
		
		#BTRFS autoScrub
		btrfs.autoScrub.enable = true;
			
	};
	
# Global hardware configuration

	hardware = {
		# Opengl & Vulkan support
		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;	
		};
		
		# Pulseaudio hardware access
		pulseaudio.enable = false;	
	};

# Enable sound.
	sound.enable = true;
	security.rtkit.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  
	users = {
		# Declarative configuration for users
		mutableUsers = false;
		
		# Current user
		users.ulad = {
		isNormalUser  = true;
		home  = "/home";
		description  = "Ulad";
		extraGroups  = [ "wheel" "adbusers" "networkmanager" "video" "audio"];
		password = " ";
  		};
	};
		

# List packages installed in system profile. To search, run:
# $ nix search wget
  
	programs = {
    	git.enable = true;
    	java.enable = true;
    	steam.enable = true;
		dconf.enable = true;
		partition-manager.enable = true;
  	};
  
	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			unstable = import unstable {
			config = config.nixpkgs.config;
			};
		};  
	};
	
	nix.autoOptimiseStore = true;
  
   
  	environment.systemPackages = with pkgs; [
  
  		# Stable apps
		
		android-tools  
		appimage-run
		audacity
		bastet
		bpytop
		compsize
		deluge
		easyeffects
		eclipses.eclipse-java
		far2l
		github-desktop
		glances
		gpick
		handbrake
		htop
		keeweb
		kitty
		krusader
		libreoffice-fresh
		libsForQt5.ark
		lm_sensors	
		mpv-unwrapped
		mullvad-vpn
		neofetch
		openvpn
		onlyoffice-bin
		pinta
		psensor
		python39Packages.secretstorage
		qdirstat
		qimgv
		qrcp
		s-tui
		tdesktop
		testdisk-qt
		xclip
		xournalpp
		xsensors
		wine-staging
		wget2
		
		# Games
		playonlinux
		unstable.mangohud
		unstable.goverlay
		unstable.vkBasalt
		unstable.replay-sorcery
    
    	# Unstable apps
    
		unstable.scrcpy
		unstable.yt-dlp
		unstable.mkvtoolnix
		unstable.vivaldi
		unstable.cudatext-gtk
		unstable.ventoy-bin
		unstable.krita
		unstable.libsForQt5.kdenlive
		
		# Plasma tilling
		libsForQt5.krohnkite
		libsForQt5.bismuth
  	];
  
  	fonts.fonts = with pkgs; [
		inter
		open-sans
		roboto
		roboto-mono
		roboto-slab
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
