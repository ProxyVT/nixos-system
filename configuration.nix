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
		kernelPackages = pkgs.linuxPackages_zen;
		 
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
	  		
	  		# Touchpad  & mouse config
	  		libinput = {
	  			enable = true;
	  		};
	  		
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
		mullvad-vpn.enable = true;
		aria2.enable = true;
		
		# Enable the OpenSSH daemon.
		openssh.enable = true;
		
		#BTRFS autoScrub
		btrfs.autoScrub.enable = true;
		
		# Synchronization service
		syncthing.enable = true;
			
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
		
		# Razer mouse notification
		openrazer.enable = true;
		
		# Bluetooth support
		bluetooth.enable = true;
	};

# Enable sound.
	sound.enable = true;
	security.rtkit.enable = true;
  
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
		adb.enable = true;
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
  	
  		# Development
  		cudatext-gtk
  		eclipses.eclipse-java
  		github-desktop
		python3Full
  		
  		# Games
		unstable.playonlinux
		unstable.mangohud
		unstable.goverlay
		unstable.vkBasalt
		unstable.replay-sorcery
		
		# Graphics
		gpick
		unstable.krita
		unstable.pinta
		unstable.qimgv
		
		# Internet
		unstable.vivaldi
		unstable.yt-dlp
		mullvad-vpn
		keeweb
		browsh
		cloudflare-warp
		firefox
		unstable.tdesktop
		
		# Server & security
		#syncthingtray
		
		# Multimedia
		audacity
		easyeffects
		handbrake
		unstable.libsForQt5.kdenlive
		unstable.mkvtoolnix
		mpv-unwrapped

		# Office
		libreoffice-qt
		onlyoffice-bin
		
		# System
		appimage-run
		bastet
		bpytop
		compsize
		far2l
		htop
		krusader
		libsForQt5.ark
		lm_sensors	
		neofetch
		psensor
		python39Packages.secretstorage
		qdirstat
		qrcp
		s-tui
		testdisk-qt
		xclip
		xournalpp
		xsensors
		yarn
		wget2
		unstable.scrcpy
		unstable.ventoy-bin
		unstable.wezterm
		
		# Plasma tilling
		libsForQt5.bismuth
  	];
  
  	fonts.fonts = with pkgs; [
		inter
		open-sans
		roboto
		roboto-mono
		roboto-slab
		jetbrains-mono
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
