  { inputs, outputs, lib, config, pkgs, ... }:
  
  {
  imports =
  [ # Include the results of the hardware scan.							
    ./hardware-configuration.nix
  ];
  
  # System boot sections
  boot = {
    supportedFilesystems = [ "ntfs" "bcachefs" ];		# Supported file systems
    kernel.sysctl."net.ipv4.ip_default_ttl" = 65;		# Sync TTL to mobile
    loader = {																				
  	  systemd-boot.enable = true;										# Systemd-boot loader config
  	  timeout = 5;																	# Linux boot section timeout
  	  efi.canTouchEfiVariables = true;
    };
  };
  
  # Nix configuration
  nix.settings = {
  	auto-optimise-store = true;   																															# Store optimization	
  	experimental-features = [ "nix-command" "flakes" ]; 																				# Enable flakes
  	#registry = lib.mapAttrs (_: value: { flake = value; }) inputs;                             # To make nix3 commands consistent with your flake
  	#nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;  # This will additionally add your inputs to the system's legacy channels
  };
  
  
  # Define your hostname.
  networking = {
    hostName = "nixos-ulad";
    networkmanager.enable = true;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };
  
  # Set your time zone.
  time = {
    timeZone = "Europe/Minsk";
    hardwareClockInLocalTime = true;
  };
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
  	font = "JetBrains Mono";
  	keyMap = "us";
  };
  
  # Global services configuration
  services = {
  
  	# Environment configuration	  
  	xserver = {
  		enable = true;
  
  		# Dekstop Manager
  		desktopManager = {
  			plasma5 = {
  		      enable = false;
  			};
  			pantheon = {
  			  enable = true;
  			};
  		};
  				
  		# Display Manager
  		displayManager = {
  			sddm = {
  				enable = false;
  				autoNumlock = true;
  			};
  			lightdm = {
              enable = true; 
  			};  			
  		};
  	
  		# Language sesttings
  		layout = "us,ru";
  		xkbOptions = "grp:win_space_toggle";
  						
  		# Touchpad  & mouse config
  		libinput = {
  			enable = true;
  		};
    };
          
  	# Sound services configuration
  	pipewire = {
  		enable = true;							# Pipewire support
  		alsa = {										# Alsa support
  			enable = true;
  			support32Bit = true;
  		};
  		pulse.enable = true;				# PulseAudio support
  	};
  	
  	printing.enable = true; 			# Printing services
  	mullvad-vpn.enable = true; 		# MullvadVPN support
  	openssh.enable = true; 				# Enable the OpenSSH daemon.
  	flatpak.enable = false; 			# Flatpak support
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
  	};	
  };
  
  sound.enable = true;					# Enable sound.
  security = {
  	rtkit.enable = true;
  	polkit.enable = true;
  	sudo.enable = true;
  	doas = {
  		enable = false;
  		extraRules = [{
        users = [ "ulad" ];
        keepEnv = true;
        persist = true;  
  		}];
  	};
  };
  
  
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
          "plugdev"
          "transmission"
          ];
      password = " ";
    };
  };      
  
  qt = {
  	enable = true;
  };
  
  system.stateVersion = "23.05";
  }
  
