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
		kernelModules = ["zfs"];
		 
		# Supported file systems
	  	supportedFilesystems = [ "ntfs" ];
	  	
	  	# Systemd-boot loader config
  		loader = {
			systemd-boot.enable = true;
			timeout = 5;
	  		efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot/efi";
			};
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
  		hardwareClockInLocalTime = true;
  	};

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.utf8"; 
	console = {
		font = "JetBrains Mono";
		keyMap = "us";
	};

	# Global services configuration
	services = {
	
		# Environment configuration	  
		xserver = {
			enable = true;
	  		
	  	# KDE Plasma Dekstop
	  	desktopManager = {
				plasma5.enable = true;
	  	};
	  		
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
		syncthing.enable = true;
		aria2 = {
			enable = true;
			rpcSecret = "september";
			extraArguments = "--enable-rpc=true --rpc-listen-all=true --rpc-allow-origin-all=true --input-file=/var/lib/aria2/aria2.session --force-save=true --allow-overwrite=true --file-allocation=none --bt-enable-lpd=true --conditional-get=true --check-integrity=true --max-concurrent-downloads=10 --max-connection-per-server=3 --seed-ratio=0 --bt-max-peers=0 --bt-request-peer-speed-limit=1000K --follow-torrent=mem --min-split-size=5M --split=10";
			downloadDir = "/run/media/ulad/aria2/Downloads";
		};
		
		# Enable the OpenSSH daemon.
		openssh.enable = true;
		
		#BTRFS autoScrub
		btrfs.autoScrub.enable = true;
		
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
		bluetooth = {
			enable = true;
			package = pkgs.bluezFull;
		};	
	};

	# Enable sound.
	sound.enable = true;
	security = {
		rtkit.enable = true;
		polkit.enable = true;
	};
	
	# Users configuration
	users = {
	
		# Declarative configuration for users
		mutableUsers = false;
		
		# Current user
		users.ulad = {
		isNormalUser = true;
		description = "Ulad";
		extraGroups = [ 
			"wheel"
			"users" 
			"adbusers"
			"networkmanager"
			"video"
			"audio"
			"aria2"
			"openrazer"
			"transmission"
			];
		password = " ";
		packages = with pkgs; [
		  	
		# Development
		libsForQt5.kate
		lite-xl
		eclipses.eclipse-java
		github-desktop
		nodejs
		nodePackages.gulp
  		
		# Games
		playonlinux
		mangohud
		goverlay
		vkBasalt
		replay-sorcery
		lutris
		
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
		flood
		qbittorrent
		#motrix - appimage
		
		# Server & security
		keepassxc
		
		# Multimedia
		audacity
		easyeffects
		handbrake
		libsForQt5.kdenlive
		mkvtoolnix
		mediainfo-gui
		mpv-unwrapped

		# Office
		libreoffice-qt
		
		# CLI
		#syncthing
		appimage-run
		bastet
		bpytop
		compsize
		psmisc
		lm_sensors
		libsForQt5.powerdevil
		libsForQt5.kscreen
		neofetch
		python39Packages.secretstorage
		s-tui
		xsensors
		wget2
		ventoy-bin
		bluetooth_battery
		scrcpy
		rtorrent
		
		# System apps
		far2l
		htop
		krusader
		libsForQt5.ark
		libsForQt5.kcalc
		gparted
		psensor
		qdirstat
		qrcp
		testdisk-qt
		lxqt.pcmanfm-qt
		lxqt.libfm-qt
		xclip
		xournalpp
		yarn
		wezterm
		
		# System components
		pacman
		kde-cli-tools
		libplacebo
		libsForQt5.bismuth
		python3Full
		glxinfo
		vulkan-tools
		wayland-utils
		xorg.xdpyinfo
		xorg.xinit
		rar
		];
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
		npm.enable = true;
		gamemode.enable = true;
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
  	];
  
  	fonts.fonts = with pkgs; [
		liberation_ttf
		open-sans
		roboto
		jetbrains-mono
		paratype-pt-serif
		libertine
		ibm-plex
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
  system.stateVersion = "unstable"; # Did you read the comment?
}
