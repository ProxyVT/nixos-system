  { inputs, outputs, lib, config, pkgs, nixpkgs, ... }:
  
  {
  imports =
  [ 			
    ./hardware-configuration.nix
  ];
  
  # System boot sections
  boot = {
    kernelPackages = pkgs.linuxPackages_6_9;
    kernel.sysctl."net.ipv4.ip_default_ttl" = 65;   # Sync TTL to mobile
    kernel.sysctl."vm.swappiness" = 180;
    loader = {																				
  	  systemd-boot = {
        enable = true;										          # Systemd-boot loader config
        sortKey = "machine-id";                     # Sort specialisation generation
      };
  	  timeout = 10;																	# Linux boot section timeout
  	  efi.canTouchEfiVariables = true;
    };
  };

  zramSwap = {
    enable = true;                                  # Zram support
    memoryPercent = 100;
    algorithm = "lz4";
  };
  
  # Nix configuration
  nix = {
    distributedBuilds = false;
    buildMachines = [
      {  hostName = "eu.nixbuild.net";
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
  };
  
  # Define your hostname.
  networking = {
    hostName = "nixos-ulad";
    networkmanager.enable = true;
  };
  
  # Set your time zone.
  time = {
    timeZone = "Europe/Minsk";
    hardwareClockInLocalTime = true;
  };
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;                  # workaround for https://github.com/NixOS/nixpkgs/issues/257904
  	keyMap = "us";
  };
  
  # Global services configuration
  services = {   
    xserver = {                         # Environment configuration	  
      enable = true;  
      desktopManager = {                # Dekstop Manager
        cinnamon.enable = true;
        gnome.enable = false;
      };	
      # Display Manager
      displayManager = {
  		  lightdm = {
  		    enable = true;
  		  };		
      };
      # Language sesttings
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle"; 
      };  
    };

    libinput = {                        # Touchpad  & mouse config
      enable = true;
    };

    desktopManager = {
      plasma6.enable = false;
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
  	openrazer = {
      enable = true;
    };
  	
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
    users = {
      ulad = {
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
  };      

  environment.persistence."/persistent" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.talyz = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local/share/direnv"
      ];
      files = [
        ".screenrc"
      ];
    };
  };
}

  environment.persistence."/persistent" = {
    enable = true;  # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.ulad = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".nixops"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
        ".local/share/direnv"
      ];
      files = [
        ".screenrc"
      ];
    };
  };

  system = {
    stateVersion = "24.05";
  };
}
  

