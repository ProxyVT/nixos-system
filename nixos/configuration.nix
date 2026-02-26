{
  inputs,
  outputs,
  pkgs,
  lib,
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
      builders-use-substitutes = true;
      eval-cores = 0;
      lazy-locks = true;
      max-jobs = 1;
      substituters = [ "https://nixos-cache-proxy.cofob.dev" ];
      tarball-ttl = 0;
      trusted-users = [ "@wheel" ];
      use-cgroups = true;
      warn-dirty = false;
      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "parallel-eval"
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
      outputs.custom-packages.default
    ];
  };

  # Define your hostname.
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
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

  # Global hardware configuration
  hardware = {
    openrazer.enable = false;
    bluetooth.enable = true;
    acpilight.enable = true;
    i2c.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.enable = false;
  };

  virtualisation.docker.enable = true;

  environment.shellAliases = {
    sudo = "run0";
    nix-gc = "run0 nix-collect-garbage -d ; nix-collect-garbage -d";
    nix-upd = "nix flake update ; nix flake archive";
    boot = "run0 nixos-rebuild boot --flake";
    switch = "run0 nixos-rebuild switch --flake";
    build = "nixos-rebuild build --flake";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = lib.mkForce ".backup";
    users.ulad.imports = [
      ../applications/home-manager
      inputs.zen-browser.homeModules.default
    ];
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
          "deluge"
          "usbmux"
        ];
        hashedPassword = "$y$j9T$saJvjo68.BgDGPQjA9WDN.$h9979vNxQrblxIxudoFl1qb8twwAMEM4uEbVJ0qCY19";
      };
    };
  };

  system = {
    stateVersion = "24.11";
  };
}
