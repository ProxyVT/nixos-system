{ inputs, outputs, lib, config, pkgs, ... }:

{ 
  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "6fa34c31d0a5290dee83282205768d15111df7d8";
            hash = "sha256-qxyNZHmH33bKRp4heFSC+RtvSApIfbVFt4otfS351nE=";
          };
          patches = [];
        });
        mpv-unwrapped = (prev.mpv-unwrapped.override {
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchgit {
              url = "https://code.videolan.org/videolan/libplacebo.git";
              rev = "311a59507f6a0465aaac9b783af65bf349755360";
              hash = "sha256-rwaufc4LfcX190ulHv0NPuER/D7//SwoLrSN4kKteqk=";
            };
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "2af3a6e294e829191dfa0c41396ecd6384d405d9";
            hash = "sha256-y4v4I88a9KRgrvuWJBGM8Q3lG1WUXrUW0O7qTCrk9nk=";
          };
          patches = [];
        });
        mpv-git = pkgs.wrapMpv final.mpv-unwrapped {
          scripts = with pkgs; [ 
            uosc-git
            mpvScripts.thumbfast
          ];
        };      
      })
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
    };
  };
  
  fonts.packages = with pkgs; [
    liberation_ttf
    open-sans
    roboto
    jetbrains-mono
    ibm-plex
    inter
  ];
  
  environment.systemPackages = with pkgs; [
  
    # Development
    super-productivity
    android-studio
    eclipses.eclipse-java
    github-desktop
    nodejs
    nodePackages.gulp
    wineWowPackages.unstableFull
    
    # Graphics
    gpick
    krita
    pinta
    blanket
    libsForQt5.spectacle
    nomacs
    digikam
    
    # Internet
    vivaldi
    vivaldi-ffmpeg-codecs
    you-get
    browsh
    cloudflare-warp
    firefox
    tdesktop
    motrix
    streamlink
    ariang
    media-downloader
    tartube-yt-dlp
    
    # Server & security
    keepassxc
    john
    putty
    protonvpn-gui
    ddrescue
    ddrescueview
    
    # Multimedia
    audacity
    handbrake
    libsForQt5.kdenlive
    mkvtoolnix
    mediainfo-gui
    qmplay2
    ffmpeg-normalize
    mpv-git
    mousai
    
    # Office
    libreoffice-qt
    
    # CLI
    appimage-run
    vrrtest
    bastet
    bottom
    broot
    compsize
    psmisc
    lm_sensors
    ffmpeg
    fastfetch
    tuifimanager
    python39Packages.secretstorage
    s-tui
    xsensors
    ventoy-bin
    bluetooth_battery
    scrcpy
    speedtest-cli
    ttop
    ddcutil
    brightnessctl
    
    # System apps
    libsForQt5.ark
    libsForQt5.dolphin
    psensor
    qdirstat
    qrcp
    testdisk-qt
    lxqt.libfm-qt
    xclip
    xournalpp
    yarn
    pavucontrol
    darkman
    localsend
    grsync
    
    # System components
    papirus-icon-theme
    polkit
    plasma-hud
    rar
    unixtools.quota
    polkit
    papirus-maia-icon-theme
    luna-icons
    libva-utils
    material-icons
    python3Full
    glxinfo
    vulkan-tools
    wayland-utils
    xorg.xdpyinfo
    xorg.xinit
  ];

  services = {
    mullvad-vpn = {
      enable = true; 	                      # Mullvad VPN support
      package = pkgs.mullvad-vpn;
    };
    flatpak.enable = false; 		            # Flatpak support
    cinnamon.apps.enable = true;            # Cinnamon apps
    gnome.gnome-keyring.enable = true;      # Gnome keyring support
    transmission = {                        # Transmission torrent service
      enable = true;
      package = pkgs.transmission_4-gtk;
      settings = {
        umask = 0;
      };     
    };
    resilio = {
      enable = false;
      enableWebUI = true;
      httpListenPort = 8888;
      httpListenAddr = "0.0.0.0";
    };
  };

  programs = {
    adb.enable = true;
    npm.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    ssh = {
      knownHosts = {
        nixbuild = {
          hostNames = [ "eu.nixbuild.net" ];
          publicKey = "sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7V1q5kKup+eSTkqpcsb7qqoKcb8V9foiZGF6dn4qqE";
        };
      };
      extraConfig = ''
        Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          ServerAliveInterval 60
          IPQoS throughput
          IdentityFile /home/ulad/my-nixbuild-key
      '';
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    file-roller.enable = true;
    gamemode.enable = true;
    thunar = {
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
    gnome-disks.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}


