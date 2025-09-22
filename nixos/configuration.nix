{
  inputs,
  outputs,
  pkgs,
  ...
}:

{
  # System boot sections
  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
    kernel = {
      sysctl = {
        "net.ipv4.ip_default_ttl" = 128;
        "vm.swappiness" = 25;
      };
      sysfs = {
        module.zswap.parameters = {
          enabled = true;
          max_pool_percent = 50;
          shrinker_enabled = true;
        };
      };
    };
    loader = {
      limine = {
        enable = true;
        secureBoot.enable = true;
        panicOnChecksumMismatch = true;
        efiInstallAsRemovable = true;
      };
      systemd-boot = {
        enable = false;
      };
      timeout = 10; # Linux boot section timeout
      efi.canTouchEfiVariables = true;
    };
  };
  zramSwap = {
    enable = false;
    memoryPercent = 25;
    priority = 100;
  };

  # Nix configuration
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    channel.enable = false;
    distributedBuilds = false;
    buildMachines = [
      {
        hostName = "eu.nixbuild.net";
        system = "x86_64-linux";
        maxJobs = 100;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
        ];
      }
    ];
    settings = {
      auto-allocate-uids = true;
      trusted-users = [ "@wheel" ];
      tarball-ttl = 0;
      builders-use-substitutes = true;
      substituters = [ "https://nixos-cache-proxy.cofob.dev" ];
      experimental-features = [
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
    };
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      outputs.overlays.packages
    ];
  };

  # Define your hostname.
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6 = {
          Enabled = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };

  # Set your time zone.
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Minsk";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "us";
  };

  # Global services configuration
  services = {
    xserver = {
      # Environment configuration
      enable = true;
      desktopManager = {
        # Dekstop Manager
        xfce.enable = true;
      };
      # Language sesttings
      xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle";
      };
    };
    libinput.enable = true;
    printing.enable = true;
    resolved.enable = true;
    pipewire.enable = true;
  };

  # XDG desktop integration
  xdg.portal = {
    enable = true;
  };

  # Global hardware configuration
  hardware = {
    openrazer.enable = false;
    bluetooth.enable = true;
    acpilight.enable = true;
    i2c.enable = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.enable = false;
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
          "storage"
          "i2c"
        ];
        hashedPassword = "$y$j9T$saJvjo68.BgDGPQjA9WDN.$h9979vNxQrblxIxudoFl1qb8twwAMEM4uEbVJ0qCY19";
      };
    };
  };

  system = {
    stateVersion = "24.11";
  };
}
