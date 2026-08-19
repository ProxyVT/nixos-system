{
  inputs,
  outputs,
  pkgs,
  lib,
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
    priority = 100;
  };

  # Nix configuration
  nix = {
    package = inputs.determinate.packages.${system}.default;
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
      max-substitution-jobs = 25;
      substituters = [
        "https://nixos-cache-proxy.cofob.dev"
        "https://proxyvt.cachix.org"
      ];
      trusted-public-keys = [
        "proxyvt.cachix.org-1:5OgxjpTkZKxSyu/4dJXa10DENZ+s/3K1unAQbCsG2qQ="
      ];
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
      inputs.agenix.overlays.default
      outputs.custom-packages.default
      (final: prev: {
        mv = inputs.multiverse.lib.mkMultiverse {
          inherit system;
          config.allowUnfree = true;
        };
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

  system = {
    stateVersion = "25.11";
  };
}
