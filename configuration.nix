# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

	{ config, pkgs, lib, ... }:

	{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];
   
	# System boot section
	boot = {
		# Linux kernel version
		kernelPackages = pkgs.linuxPackages_lqx;
		 
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
	  		
	  		# KDE Plasma Dekstop
	  		desktopManager.plasma5.enable = true;
	  		
	  		# SDDM Display Manager
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
		aria2 = {
			enable = true;
			openPorts = true;
			extraArguments = "--rpc-listen-all --remote-time=true";
		};
		
		# Enable the OpenSSH daemon.
		openssh.enable = true;
		
		#BTRFS autoScrub
		btrfs.autoScrub.enable = true;
		
		# Synchronization service
		syncthing.enable = true;
		
		# Flatpak support
		flatpak.enable = true;	
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
		ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
  	};
  
	nixpkgs.config = {
		allowUnfree = true;
	};
	
	# Nix configuration
	nix = {
	
		# Store optimization	
		autoOptimiseStore = true;
		
		# Enable flakes
		settings.experimental-features = [ "nix-command" "flakes" ];
	};
  
   
  	environment.systemPackages = with pkgs; [
  	
  		# Development
  		cudatext-gtk
  		eclipses.eclipse-java
  		github-desktop
		python3Full
		glxinfo
		vulkan-tools
		wayland-utils
		xorg.xdpyinfo
  		
  		# Games
		playonlinux
		mangohud
		goverlay
		vkBasalt
		replay-sorcery
		
		# Graphics
		gpick
		krita
		pinta
		qimgv
		blanket
		
		# Internet
		vivaldi
		yt-dlp
		mullvad-vpn
		browsh
		cloudflare-warp
		firefox
		tdesktop
		libsForQt5.ktorrent
		#motrix - appimage
		
		# Server & security
		syncthingtray
		keepassxc
		
		# Multimedia
		audacity
		easyeffects
		handbrake
		libsForQt5.kdenlive
		mkvtoolnix
		mpv-unwrapped

		# Office
		libreoffice-qt
		#onlyofficebin - flatpak
		
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
		libsForQt5.powerdevil
		libsForQt5.kscreen
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
		scrcpy
		ventoy-bin
		bluetooth_battery
		
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
		paratype-pt-serif
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
  system.stateVersion = "22.05"; # Did you read the comment?
}
