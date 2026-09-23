{
  pkgs,
  lib,
  extraPkgs,
  overlaysList,
  system,
  config,
  ...
}:

{
  # System boot sections
  boot = {
    kernelPackages = pkgs.linuxPackages_6_18;
    kernel = {
      sysctl = {
        "net.ipv4.ip_default_ttl" = 65;
        "vm.swappiness" = 50;
      };
    };
    loader = {
      limine = {
        enable = true;
        package = (pkgs.mv.at "26.05").limine-full;
        secureBoot.enable = true;
        panicOnChecksumMismatch = true;
        efiInstallAsRemovable = true;
        additionalFiles = {
          "efi/memtest86/memtest86.efi" = "${(pkgs.mv.at "26.05").memtest86-efi}/BOOTX64.efi";
        };
      };
      systemd-boot = {
        enable = false;
      };
      timeout = 20;
      efi.canTouchEfiVariables = true;
    };
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # Nix configuration
  nix = {
    channel.enable = false;
    distributedBuilds = false;
    buildMachines = [
      {
        inherit system;
        hostName = "eu.nixbuild.net";
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
      lazy-trees = true;
      lazy-locks = true;
      substituters = [
        "https://cache.flakehub.com"
        "https://install.determinate.systems"
        "https://nixos-cache-proxy.cofob.dev"
        "https://proxyvt.cachix.org"
      ];
      trusted-public-keys = [
        "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
        "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
        "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
        "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
        "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
        "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
        "proxyvt.cachix.org-1:5OgxjpTkZKxSyu/4dJXa10DENZ+s/3K1unAQbCsG2qQ="
      ];
      tarball-ttl = 0;
      trusted-users = [ "@wheel" ];
      use-cgroups = true;
      warn-dirty = false;
      http3 = true;
      http-connections = 16;
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
    overlays = overlaysList ++ [
      (_: _:{
        nix = extraPkgs.nix;
      })
    ];
  };

  # Define your hostname.
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = false;
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
        xfce = {
          enable = true;
          enableWaylandSession = true;
        };
      };
      displayManager.lightdm.greeters.gtk = {
        enable = true;
        extraConfig = ''
          keyboard=onboard
        '';
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
    sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
    };
    swapspace.enable = true;
  };

  # Global hardware configuration
  hardware = {
    enableAllHardware = true;
    enableAllFirmware = true;
    openrazer.enable = true;
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
    extraSpecialArgs = { inherit extraPkgs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = lib.mkForce ".backup";
    users.ulad.imports = [
      ../applications/home-manager
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
          "flatpak"
        ];
        hashedPassword = "$y$j9T$saJvjo68.BgDGPQjA9WDN.$h9979vNxQrblxIxudoFl1qb8twwAMEM4uEbVJ0qCY19";
        hashedPasswordFile = config.age.secrets.default.path;
      };
    };
  };

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets.default = {
      file = ../default.age;
      owner = "root";
    };
  };


  systemd.enableStrictShellChecks = true;

  system = {
    stateVersion = "25.11";
  };
}
