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
    kernelPackages = pkgs.linuxPackages_6_18;
    kernel = {
      sysctl = {
        "net.ipv4.ip_default_ttl" = 65;
        "vm.swappiness" = 1;
      };
      sysfs = {
        module = {
          zswap.parameters = {
            enabled = true;
            shrinker_enabled = true;
          };
        };
      };
    };
    loader = {
      limine = {
        enable = true;
        package = pkgs.release.limine-full;
        secureBoot.enable = true;
        panicOnChecksumMismatch = true;
        efiInstallAsRemovable = true;
        additionalFiles = {
          "efi/memtest86/memtest86.efi" = "${pkgs.release.memtest86-efi}/BOOTX64.efi";
        };
      };
      systemd-boot = {
        enable = false;
      };
      timeout = 20;
      efi.canTouchEfiVariables = true;
    };
  };

  # Nix configuration
  nix = {
    package = inputs.determinate.packages.${pkgs.stdenv.hostPlatform.system}.default;
    channel.enable = false;
    distributedBuilds = false;
    settings = {
      auto-allocate-uids = true;
      builders-use-substitutes = true;
      eval-cores = 0;
      lazy-locks = true;
      max-jobs = 4;
      max-substitution-jobs = 8;
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
    ];
  };

  # Define your hostname.
  networking = {
    hostName = "michael";
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = false;
      settings = {
        wifi-sec.pmf = 1;
      };
    };
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Minsk";
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;
      desktopManager = {
        lxqt.enable = true;
      };
      displayManager.lightdm.greeters.gtk = {
        enable = true;
        extraConfig = ''
          keyboard=onboard
        '';
      };
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
    enableAllHardware = true;
    enableAllFirmware = true;
    bluetooth.enable = true;
    acpilight.enable = true;
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
  };

  users = {
    mutableUsers = false;
    users = {
      michael = {
        isNormalUser = true;
        description = "Michael";
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
          "rtorrent"
          "usbmux"
        ];
        hashedPassword = "$y$j9T$saJvjo68.BgDGPQjA9WDN.$h9979vNxQrblxIxudoFl1qb8twwAMEM4uEbVJ0qCY19";
      };
    };
  };

  system = {
    stateVersion = "26.05";
  };
}
