{ inputs, outputs, lib, config, pkgs, ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped = prev.mpv-unwrapped.override {
          ffmpeg_5 = pkgs.ffmpeg_6-full;
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "6.292.1";
            src = pkgs.fetchFromGitLab {
              domain = "code.videolan.org";
              owner = "videolan";
              repo = pname;
              rev = "v${version}";
              hash = "sha256-/GIN9ROaF5aR79qkBwj5BCzKYUjQn+5jRnSlHUeSLHQ=";
            };
          });
        };
        mpv = prev.wrapMpv final.mpv-unwrapped {
          scripts = [ 
            final.mpvScripts.uosc
            final.mpvScripts.thumbfast
          ];
        };
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };
  
  fonts.packages = with pkgs; [
    liberation_ttf
    open-sans
    roboto
    jetbrains-mono
    ibm-plex
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
    
    # Graphics
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
    mpv
    
    # Office
    libreoffice-qt
    
    # CLI
    appimage-run
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
    
    # System components
    papirus-icon-theme
    polkit
    plasma-hud
    rar
    unixtools.quota
    polkit
    papirus-maia-icon-theme
    luna-icons
    material-icons
    python3Full
    python-qt
    glxinfo
    vulkan-tools
    wayland-utils
    xorg.xdpyinfo
    xorg.xinit
  ];

  programs = {
    adb.enable = true;
    steam.enable = true;
    npm.enable = true;
    dconf.enable = true;
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    gamemode.enable = true;
    gnome-disks.enable = true;
    pantheon-tweaks.enable = false;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}


