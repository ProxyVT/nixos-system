{ pkgs, lib, ... }: {

imports = (lib.filesystem.listFilesRecursive ./modules);

fonts.packages = with pkgs; [
  liberation_ttf
  open-sans
  roboto
  jetbrains-mono
  ibm-plex
  inter
];

environment = {
  systemPackages = with pkgs; [

    # Development
    super-productivity
    github-desktop
    nodejs
    cudatext-gtk
    lite-xl
    nodePackages.gulp
    nodePackages.pnpm
    wineWowPackages.unstableFull
    nixpkgs-review
    zed-editor
    warp-terminal
    waveterm
    windterm
    ghostty
    vscode-fhs

    # Graphics
    edge.gpick
    krita
    pinta
    blanket
    libsForQt5.spectacle

    # Internet
    you-get
    browsh
    vivaldi
    motrix
    edge.persepolis
    ariang
    media-downloader
    element-desktop
    edge.telegram-desktop
    tor

    # Server & security
    keepassxc
    ddrescue
    ddrescueview
    electrum
    tradingview

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
    ffmpeg-full
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
    nixfmt-rfc-style

    # System apps
    resources
    monitorets
    qdirstat
    qrcp
    testdisk-qt
    xclip
    xournalpp
    yarn
    pavucontrol
    darkman
    grsync
    edge.rsync
    nix-prefetch-git
    nix-prefetch-scripts
    mission-center
    nemo-with-extensions
    edge.peazip
    picom

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
    legacy.luna-icons
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
    ffmpegthumbnailer
  ] 
  ++ 
  (with pkgsCross; [
    mingw32.dxvk_1
    mingwW64.dxvk_1
  ]);  
};  

services = {
  cinnamon.apps.enable = false;           # Cinnamon apps
  gnome.gnome-keyring.enable = true;      # Gnome keyring support
  usbmuxd.enable = true;                  # Usbmuxd support
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
