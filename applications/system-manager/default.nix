{ inputs, outputs, lib, config, pkgs, ... }: {

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
    cudatext
    lite-xl
    nodePackages.gulp
    nodePackages.pnpm
    wineWowPackages.unstableFull
    nixpkgs-review
    unstable.zed-editor
    warp-terminal

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
    ariang
    media-downloader
    element-desktop
    telegram-desktop

    # Server & security
    keepassxc
    ddrescue
    ddrescueview
    electrum

    # Multimedia
    handbrake
    mkvtoolnix
    mediainfo-gui
    qmplay2
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
    psmisc
    lm_sensors
    ffmpeg
    fastfetch
    tuifimanager
    python39Packages.secretstorage
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

    # System apps
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
    nix-prefetch-git
    nix-prefetch-scripts

    # System components
    papirus-icon-theme
    polkit
    plasma-hud
    exfat
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
    libimobiledevice
    ifuse
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-ugly
  ];

  services = {
    cinnamon.apps.enable = true;            # Cinnamon apps
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
  };

}
