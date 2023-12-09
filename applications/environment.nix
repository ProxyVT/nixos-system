{ inputs, outputs, lib, config, pkgs, fetchFromGitHub, ... }:

{ 
  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped = (prev.mpv-unwrapped.override {
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchgit {
              url = "https://code.videolan.org/videolan/libplacebo.git";
              rev = "795600a44b03fcd52c055981a403ad60ee5d027a";
              hash = "sha256-iTVWbfn5SDVxzpuNFNB1zUBtTRFGkzrBgsiRnYTexf8=";
            };
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "f886eb5678d0ed7eea196e577e04525248963f28";
            hash = "sha256-nMXo1mp1hL2Zu4xkSUb0Sfa9/KLm3u29K7XLYtzy8Oo=";
          };
        });
        mpv-git = pkgs.wrapMpv final.mpv-unwrapped {
          scripts = with pkgs.mpvScripts; [ 
            #uosc
            thumbfast
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
    lite-xl
    lapce
    eclipses.eclipse-java
    github-desktop
    nodejs
    nodePackages.gulp
    wineWowPackages.unstableFull
    
  #   # Graphics
    gpick
    krita
    pinta
    blanket
    libsForQt5.spectacle
    
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
    deluge
    ktorrent
    ariang
    
    # Server & security
    keepassxc
    john
    putty
    protonvpn-gui
    
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
    pantheon.appcenter
    far2l
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
    
    # Xfce applets
    xfce.catfish
    xfce.gigolo
    xfce.orage
    xfce.xfburn
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-dict
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-genmon-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-panel
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfdashboard
    xfce.xfwm4
    xfce.xfwm4-themes
  ];

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


