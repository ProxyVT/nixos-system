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
  
  services = {
    syncthing.enable = true;
    easyeffects.enable = true;
  };
  
  programs = {
    home-manager.enable = true;
    btop.enable = true;
    bash.enable = true;
    gnome-terminal = {
      enable = false;
      profile.myConfig = {
        default = true;
        visibleName = "my-config";
      };
    };
    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "Default";
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
          "browser.tabs.closeWindowWithLastTab" = false;
          "toolkit.tabbox.switchByScrolling" = true;          
        };
      };
    };
    yt-dlp.enable = true;
    wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
        return {
          font = wezterm.font("JetBrains Mono"),
          font_size = 16.0,
          color_scheme = "Tomorrow Night",
          enable_scroll_bar = true,
        }
      '';
    };
    java.enable = true;
    mpv = {
      enable = false;
      scripts = with pkgs; [
        mpvScripts.uosc
        mpvScripts.thumbfast
      ];
    };
    nnn.enable = true;
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
        conditional-get = true;
        max-concurrent-downloads = 10; 
        max-connection-per-server = 3; 
        seed-ratio = 0;
        enable-dht6 = true;
        bt-max-peers = 255;
        follow-torrent = "mem";
        min-split-size = "8M";
        split = 32;
      };
    };
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
 
