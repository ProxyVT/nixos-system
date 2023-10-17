{ inputs, outputs, lib, config, pkgs, fetchFromGitHub,... }:

{ 
  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped = (prev.mpv-unwrapped.override {
          ffmpeg_5 = (prev.ffmpeg_6-full.override {
            withCuda = false;
            withNvdec = false;
            withNvenc = false;
          }).overrideAttrs (oldAttrs: rec {
            pname = "ffmpeg";
            version = "git";
              src = prev.fetchgit {
                url = "https://git.ffmpeg.org/ffmpeg.git";
                rev = "5ddab49d48343385eadb3a435a5491c476b66ecc";
                hash = "sha256-TZylnfcdv2hFgj1pCyLA2MWtitUDN5DNJojWqgrsDPA=";
              };
            patches = [];
            postPatch = '''';
          });
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchFromGitHub {
              owner = "haasn";
              repo = pname;
              rev = "7ca8418";
              hash = "sha256-RBDO2Bk46tXIGBBP0eGiM6cDr3zg5GESaLYQqnQD4BY=";
            };
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchFromGitHub {
            owner = "mpv-player";
            repo = pname;
            rev = "81dea90";
            hash = "sha256-ToEM35MyexXlv6vwF0VSZs5LJ4uoOgUn/one0IamVcY=";
          };
        });
        mpv-git = pkgs.wrapMpv final.mpv-unwrapped {
          scripts = with pkgs; [ 
            mpvScripts.uosc
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
    lite-xl
    lapce
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
    qimgv
    
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
    ffmpeg_6-full
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
    python-qt
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
    pantheon-tweaks.enable = false;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}


