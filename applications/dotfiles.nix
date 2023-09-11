# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "ulad";
    homeDirectory = "/home/ulad";
  };
  
  #accounts.email.ulad.thunderbird.enable = true;
  
  services = {
    syncthing.enable = true;
    easyeffects.enable = true;
  };
  
  programs = {
    home-manager.enable = true;
    thunderbird = {
      enable = true;
      profiles.ulad = {
        isDefault = true;
      };
    };
    
    # Monitor config
    autorandr = {
      enable = false;
      profiles.ulad = {
        fingerprint = {
          eDP1 = "00ffffffffffff0006afec4100000000291701049522137802bbf5945554902723505400000001010101010101010101010101010101ce1d56c050003030080a310058c1100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231353658544e30342e31200a00ec";
          HDMI1 = "00ffffffffffff0026cd5b615d010000321e010380351e782a82b5a4554fa0260e5054bfcf00814081809500714f81c0b30001010101023a801871382d40582c45000f282100001eb37d806a703817402c2035000f282100001e000000fd0030901eb422000a202020202020000000fc00504c32343730480a2020202020019002032ff14e010304131f120211900e0f1d1e3f230907078301000065030c0010006d1a000002013090e60000000000b37d806a703817402c2035000f282100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000085";
        };
        config = {
          eDP1.enable = false;
          HDMI1 = {
            enable = true;
            crtc = 0;
            primary = true;
            rate = "60.00";
          };
        };
      };
    };
    
    # Btop config
    btop = {
      enable = true;
      settings = {
        update_ms = 1000;
        proc_sorting = "memory";
      };  
    };
    
    # Bash config
    bash.enable = true;
    
    # Gnome terminal
    gnome-terminal = {
      enable = true;
      profile."060efe23-3ab4-4c71-8a38-dd13f89b400d" = {
        visibleName = "Ulad";
        default = true;
      };
      themeVariant = "system";
      showMenubar = true;
    };
    
    # Firefox browser
    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "Default";
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.tabs.closeWindowWithLastTab" = false;
          "toolkit.tabbox.switchByScrolling" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "gfx.webrender.all" = true;
        };
      };
    };
    
    # yt-dlp config
    yt-dlp = {
      enable = true;
      extraConfig = ''
        -S "res:1440"
      '';
    };
    
    # Java config
    java.enable = true;
    
    # mpv player config
    mpv = {
      enable = false;
      scripts = with pkgs; [
        mpvScripts.uosc
        mpvScripts.thumbfast
      ];
    };
    
    # nnn config
    nnn.enable = true;
    
    # Aria2c config
    aria2 = {
      enable = true;
      settings =  {
        enable-rpc = true;
        rpc-listen-all = true;
        rpc-allow-origin-all = true;
        rpc-secret = "september";
        disk-cache = "64M"; 
        force-save = true;
        continue = true;
        pause-metadata = true;
        save-session = "/home/ulad/.config/aria2/aria2.session";
        input-file = "/home/ulad/.config/aria2/aria2.session";
        auto-save-interval = 60;
        save-session-interval = 60;
        allow-overwrite = true; 
        file-allocation = "none";
        bt-enable-lpd = true;
        bt-save-metadata = true;
        bt-load-saved-metadata = true;
        bt-remove-unselected-file = true;
        bt-max-peers = 0;
        bt-detach-seed-only = true;
        conditional-get = true;
        max-concurrent-downloads = 100; 
        max-connection-per-server = 16;
        dht-listen-port = "50101-50109"; 
        seed-ratio = 0;
        enable-dht6 = true;
        follow-torrent = "mem";
        min-split-size = "8M";
        split = 32;
        async-dns = false;
      };
    };
    
    # SSH config
    ssh = {
      enable = false;
    };
  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
 
