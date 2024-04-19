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
    easyeffects.enable = true;
    gpg-agent.enable = true;
  };
  
  programs = {
    home-manager.enable = true;
    
    # Mail Thunderbird config
    thunderbird = {
      enable = true;
      profiles.ulad = {
        isDefault = true;
      };
    };
    
    # Monitor config
    autorandr = {
      enable = true;
      profiles.ulad = {
        fingerprint = {
          eDP1 = "00ffffffffffff0006afec4100000000291701049522137802bbf5945554902723505400000001010101010101010101010101010101ce1d56c050003030080a310058c1100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231353658544e30342e31200a00ec";
          HDMI1 = "00ffffffffffff0026cd5b615d010000321e010380351e782a82b5a4554fa0260e5054bfcf00814081809500714f81c0b30001010101023a801871382d40582c45000f282100001eb37d806a703817402c2035000f282100001e000000fd0030901eb422000a202020202020000000fc00504c32343730480a2020202020019002032ff14e010304131f120211900e0f1d1e3f230907078301000065030c0010006d1a000002013090e60000000000b37d806a703817402c2035000f282100001e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000085";
        };
        config = {
          eDP1.enable = true;
          HDMI1 = {
            enable = true;
            primary = true;
            rate = "120.00";
          };
        };
      };
    };
    
    # Btop config
    btop = {
      enable = true;
      settings = {
        update_ms = 1500;
        proc_sorting = "memory";
      };  
    };
    
    # Bash config
    bash = {
      enable = true;
      bashrcExtra = "cd ./nixos-system/";
    };
    
    # Mangohud config
    mangohud = {
      enable = false;
      enableSessionWide = false;
      settingsPerApplication = {
        mpv = {
          no_display = true;
        };
      };
    };
    
    # Wezterm terminal config
    wezterm = {
      enable = true;
      extraConfig = ''
        return {
          enable_scroll_bar=true
        }
      '';
    };
    
    # Firefox browser
    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "Default";
        settings = {
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
    };
    
    # Java config
    java.enable = true;

    # Vscode config
    vscode = {
      enable = true;
      package = pkgs.vscodium-fhs;
      enableUpdateCheck = false;
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
        auto-save-interval = 10;
        save-session-interval = 10;
        allow-overwrite = true; 
        file-allocation = "none";
        bt-enable-lpd = true;
        bt-save-metadata = true;
        bt-load-saved-metadata = true;
        bt-remove-unselected-file = true;
        bt-detach-seed-only = true;
        bt-max-peers = 128;
        conditional-get = true;
        max-concurrent-downloads = 10; 
        enable-dht6 = true;
        dht-listen-port = "50101-50109"; 
        seed-ratio = 0;
        follow-torrent = "mem";
        min-split-size = "1M";
      };
    };
    
    chromium = {
      enable = true;
    };
    
    gpg.enable = true;
  };
  
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
 
