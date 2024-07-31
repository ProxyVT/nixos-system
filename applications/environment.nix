{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports =
  [
    ./overlays/mpv.nix
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
    zed-editor

    # Graphics
    gpick
    krita
    pinta
    blanket
    libsForQt5.spectacle

    # Internet
    you-get
    browsh
    firefox
    vivaldi
    tdesktop
    motrix
    ariang
    media-downloader

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
  ];

  services = {
    mullvad-vpn = {
      enable = true; 	                      # Mullvad VPN support
      package = pkgs.mullvad-vpn;
    };
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
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
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
      gamescopeSession.enable = true;
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
      config = {
        user = {
          name = "ProxyVT";
          email = "tikit.us@outlook.com";
        };
        safe.directory = "/home/ulad/nixos-system/";
      };
    };
    gamemode.enable = true;
    gnome-disks.enable = true;
    partition-manager.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
