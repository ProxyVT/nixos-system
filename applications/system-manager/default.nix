{ pkgs, ... }: {

  imports = [
    ./overlays/mpv.nix
    ./git.nix
    ./gnupg.agent.nix
    ./mullvad-vpn.nix
    ./resilio.nix
    ./ssh.nix
    ./steam.nix
    ./transmission.nix
    ./usbmuxd.nix
  ];

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
    github-desktop
    nodejs
    cudatext-gtk
    lapce
    lite-xl
    nodePackages.gulp
    nodePackages.pnpm
    wineWowPackages.unstableFull
    nixpkgs-review
    zed-editor
    master.warp-terminal
    master.waveterm
    master.windterm

    # Graphics
    gpick
    krita
    pinta
    blanket
    libsForQt5.spectacle
    redshift

    # Internet
    you-get
    browsh
    vivaldi
    motrix
    master.persepolis
    ariang
    media-downloader
    element-desktop
    telegram-desktop

    # Server & security
    keepassxc
    ddrescue
    ddrescueview
    release.electrum

    # Multimedia
    audacity
    handbrake
    mkvtoolnix
    mediainfo-gui
    qmplay2
    mpv-git
    mousai
    subtitleedit

    # Games
    pcsx2
    heroic
    libstrangle

    # Office
    libreoffice-qt
    simple-scan

    # CLI
    appimage-run
    vrrtest
    bastet
    bottom
    broot
    psmisc
    lm_sensors
    ffmpeg
    fastfetch
    tuifimanager
    python312Packages.secretstorage
    s-tui
    xsensors
    ventoy-full
    bluetooth_battery
    scrcpy
    speedtest-cli
    ttop
    ddcutil
    brightnessctl
    nurl
    nix-tree
    fio
    ffmpeg-normalize
    toybox

    # System apps
    release.psensor
    qdirstat
    qrcp
    testdisk-qt
    lxqt.libfm-qt
    xclip
    xournalpp
    yarn
    pavucontrol
    darkman
    grsync
    nix-prefetch-git
    nix-prefetch-scripts
    mission-center

    # System components
    nixd
    papirus-icon-theme
    polkit
    plasma-hud
    exfat
    rar
    unixtools.quota
    polkit
    papirus-maia-icon-theme
    release.luna-icons
    libva-utils
    material-icons
    python3Full
    glxinfo
    vulkan-tools
    wayland-utils
    xorg.xdpyinfo
    xorg.xinit
    libimobiledevice
    ifuse
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-ugly
    gcc
    cmake
    xfce.tumbler
    xfce.xfce4-xkb-plugin
  ];

  services = {
    cinnamon.apps.enable = false;           # Cinnamon apps
    gnome.gnome-keyring.enable = true;      # Gnome keyring support
  };

  programs = {
    adb.enable = true;
    npm.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    gamemode.enable = true;
    gnome-disks.enable = true;
    partition-manager.enable = true;
    mtr.enable = true;
    localsend.enable = true;
    openvpn3.enable = true;
  };

}
