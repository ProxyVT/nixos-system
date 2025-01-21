  { outputs, pkgs, lib, ... }: {

  imports =
  [
    ./hardware.nix
  ];

  # System boot sections
  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
    kernel.sysctl."net.ipv4.ip_default_ttl" = 65;       # Sync TTL to mobile
    kernel.sysctl."vm.swappiness" = 1;
    loader = {
  	  systemd-boot = {
        enable = true;                                  # Systemd-boot loader config
        sortKey = "machine-id";                         # Sort specialisation generation
      };
  	  timeout = 10;                                     # Linux boot section timeout
  	  efi.canTouchEfiVariables = true;
    };
  };

  zramSwap = {                                          # Zram support
    enable = true;
    memoryPercent = 100;
  };

  # Nix configuration
  nix = {
    package = pkgs.lix;
    channel.enable = false;
    distributedBuilds = true;
    buildMachines = [
      { 
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [ "benchmark" "big-parallel" ];
      }
    ];
    settings = {
      builders-use-substitutes = true;
      substituters = lib.mkForce [
        "https://nixos-cache-proxy.cofob.dev"
        "ssh://eu.nixbuild.net"
      ];
      trusted-public-keys = [
        "nixbuild.net/3IOSBM-1:02cVSSXiBt+nt1gjM/5tUkY1p9r+oPn7/me9Vh9EfSE="
      ];
      auto-optimise-store = true;                       # Store optimization
      experimental-features = [                         # Enable flakes
         "nix-command"
         "flakes"
         "auto-allocate-uids"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      allowUnsupportedSystem = true;
    };
    overlays = [ outputs.overlays.packages ];
  };

  # Define your hostname.
  networking = {
    hostName = "nixos-ulad";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Minsk";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;                                  # workaround for https://github.com/NixOS/nixpkgs/issues/257904
  	keyMap = "us";
  };

  # Global services configuration
  services = {
    xserver = {                                         # Environment configuration
      enable = true;
      desktopManager = {                                # Dekstop Manager
        xfce.enable = true;
      };
      # Language sesttings
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle";
      };
    };

    libinput = {                                        # Touchpad  & mouse config
      enable = true;
    };

    # Sound services configuration
    pipewire = {
      enable = true;                                      # Pipewire support
      alsa.enable = true;                                 # Alsa support
      pulse.enable = true;                                # PulseAudio support
    };
    printing.enable = true;                             # Printing services
  };

  # XDG desktop integration
  xdg.portal = {
    enable = true;
  };

  # Global hardware configuration
  hardware = {

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

  security = {
  	rtkit.enable = true;
  	polkit.enable = true;
  	sudo.enable = false;
  	doas = {
  	  enable = true;
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
        hashedPassword = "$y$j9T$saJvjo68.BgDGPQjA9WDN.$h9979vNxQrblxIxudoFl1qb8twwAMEM4uEbVJ0qCY19";
      };
    };
  };
  system = {
    stateVersion = "24.05";
  };
}
