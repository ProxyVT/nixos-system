{ config, pkgs, lib, ... }:

{
imports =
[ # Include the results of the hardware scan.							
	./hardware-configuration.nix			
	<home-manager/nixos>
];

# System boot sections
boot = {	
	kernelPackages = pkgs.linuxPackages_latest;			# Linux kernel version
	kernelModules = ["zfs"];												# Linux kernel modules
	supportedFilesystems = ["ntfs"];								# Supported file systems
	kernel.sysctl."net.ipv4.ip_default_ttl" = 65;		# Sync TTL to mobile
	loader = {																				
		systemd-boot.enable = true;										# Systemd-boot loader config
	  timeout = 5;																	# Linux boot section timeout
	  efi = {
	  	canTouchEfiVariables = true;
	    efiSysMountPoint = "/boot/efi";
	  };
	};
};

# Nix configuration
nix.settings = {
	auto-optimise-store = true;   																															# Store optimization	
	experimental-features = [ "nix-command" "flakes" ]; 																				# Enable flakes
	registry = lib.mapAttrs (_: value: { flake = value; }) inputs;															#	To make nix3 commands consistent with your flake
	nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;		# This will additionally add your inputs to the system's legacy channels
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
	timeZone = "Europe/Istanbul";
};

# Select internationalisation properties.
i18n.defaultLocale = "en_US.utf8";
i18n.extraLocaleSettings = {
	LC_ADDRESS = "eo";
	LC_IDENTIFICATION = "eo";
	LC_MEASUREMENT = "eo";
	LC_MONETARY = "eo";
	LC_NAME = "eo";
	LC_NUMERIC = "eo";
	LC_PAPER = "eo";
	LC_TELEPHONE = "eo";
	LC_TIME = "eo";
};
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
				enable = true;
			};
		};
				
		# Display Manager
		displayManager = {
			sddm = {
				enable = true;
				autoNumlock = true;
				};
			defaultSession = "plasmawayland";
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
        packages = with pkgs; [
        ];
};
};

home-manager.users.ulad = {
  services = {
    syncthing.enable = true;
	  easyeffects.enable = true;
    };
    programs = {
    btop.enable = true;
    bash.enable = true;
    yt-dlp.enable = true;
    alacritty.enable = true;
    wezterm.enable = true;
    git.enable = true;
    java.enable = true;
    zsh.enable = true;
    mpv.enable = true;
    nnn.enable = true;
    aria2 = {
      enable = false;
      settings =  {
        enable-rpc = true;
        rpc-listen-all = true;
        rpc-allow-origin-all = true;
        rpc-secret = "september";
        disk-cache = "32M"; 
        force-save = true;
        save-session = "$HOME/.config/aria2/aria2.session";
        auto-save-interval = 10;
        save-session-interval = 10;
        allow-overwrite = true; 
        file-allocation = "none";
        bt-enable-lpd = true;
        conditional-get = true; 
        check-integrity = true;
        max-concurrent-downloads = 10; 
        max-connection-per-server = 3; 
        seed-ratio = 0;
        enable-dht6 = true;
        bt-max-peers = 255;
        follow-torrent = "mem";
        min-split-size = "1M";
        split = 10;
        };
    };
  };
};
        
# List packages installed in system profile. To search, run:
# $ nix search wget

qt = {
	enable = true;
	platformTheme = "kde";
};

programs = {
	adb.enable = true;
	steam.enable = true;
	partition-manager.enable = true;
	npm.enable = true;
	dconf.enable = true;
	gamemode.enable = true;
	gnome-disks.enable = true;
	xwayland.enable = true;
	mtr.enable = true;
	gnupg.agent = {
	enable = true;
	enableSSHSupport = true;
	};
	ssh = {
		askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
		setXAuthLocation = false;
	};
};

fonts.fonts = with pkgs; [
	liberation_ttf
	open-sans
	roboto
	jetbrains-mono
	ibm-plex
];

system.stateVersion = "23.05";
}

