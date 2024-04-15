  { inputs, outputs, lib, config, pkgs, nixpkgs, ... }:
  
  {
  imports =
  [ # Include the results of the hardware scan.							
    ./hardware-configuration.nix
  ];
  
  # System boot sections
  boot = {
    supportedFilesystems = [ ];		                  # Supported file systems
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl."net.ipv4.ip_default_ttl" = 65;   # Sync TTL to mobile
    kernel.sysctl."vm.swappiness" = 1;
    loader = {																				
  	  systemd-boot.enable = true;										# Systemd-boot loader config
  	  timeout = 5;																	# Linux boot section timeout
  	  efi.canTouchEfiVariables = true;
    };
    tmp = {
      useTmpfs = true;
    };
  };
  
  # Nix configuration
  nix = {
    distributedBuilds = false;
    buildMachines = [
      { hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
    settings = {
      auto-optimise-store = true;   													# Store optimization	
      experimental-features = [ "nix-command" "flakes" ];     # Enable flakes
    };  																				
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
    xserver = {                         # Environment configuration	  
      enable = true;  
      desktopManager = {                # Dekstop Manager
        cinnamon.enable = true;
      };	
    # Display Manager
      displayManager = {
        defaultSession = "cinnamon";
  		  lightdm = {
  		    enable = true;
  		  };		
      };
      # Language sesttings
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle"; 
      };
      # Touchpad  & mouse config
      libinput = {
        enable = true;
      };
    };         
    # Sound services configuration
    pipewire = {
      enable = true;                        # Pipewire support
    alsa = {                                # Alsa support
  		enable = true;
  		support32Bit = true;
    };
    pulse.enable = true;		                # PulseAudio support
    };
    printing.enable = true; 		            # Printing services
    logrotate.checkConfig = false;
  };
  
  # XDG desktop integration
  xdg.portal = {
    enable = true;
  };
  
  # Global hardware configuration
  hardware = {
  
  	# Opengl & Vulkan support
  	opengl = {
  		enable = true;
  		driSupport = true;
  		driSupport32Bit = true;
  		# For Steam
  		#extraPackages = with pkgs; [ mangohud ];
      #extraPackages32 = with pkgs; [ mangohud ];
  	};
  	
  	# Pulseaudio hardware access
  	pulseaudio.enable = false;
  	
  	# Razer mouse notification
  	openrazer.enable = true;
  	
  	# Bluetooth support
  	bluetooth = {
  	  enable = true;
  	};
  	
  	# Brightness control
  	acpilight.enable = true;
  	
    # i2c devices support
    i2c.enable = true;	
  };
  
  sound = {
    enable = true;                # Enable sound.
    mediaKeys.enable = true;      # Enable keyboard mediakeys
  };
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
      group = "users";
      extraGroups = [ 
        "wheel"
        "adbusers"
        "networkmanager"
        "video"
        "audio"
        "aria2"
        "openrazer"
        "plugdev"
        "transmission"
        "storage"
        "rslsync"
      ];
      password = " ";
    };
  };      
  
  qt = {
  	enable = false;
  };
  
  system.stateVersion = "23.05";
  }
  
