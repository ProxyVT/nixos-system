# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    #outputs.impermanence.nixosModules.home-manager.impermanence

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "ulad";
    homeDirectory = lib.mkForce "/persistent/home/ulad";
  };
  
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
    
    # Btop config
    btop = {
      enable = true;
      settings = {
        update_ms = 1000;
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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
