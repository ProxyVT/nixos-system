{ pkgs, lib, ... }:
{

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
      zed-editor_git
      waveterm
      windterm
      ghostty
      kiro

      # Graphics
      gpick
      krita
      pinta
      blanket
      libsForQt5.spectacle

      # Internet
      you-get
      browsh
      vivaldi
      motrix
      persepolis
      ariang
      media-downloader
      element-desktop
      telegram-desktop_git
      tor
      skype.skypeforlinux
      release.skypeexport
      epiphany
      kdePackages.ktorrent
      betterdiscord-installer
      discord

      # Server & security
      keepassxc
      ddrescue
      ddrescueview
      electrum
      tradingview
      sshuttle

      # Multimedia
      audacity
      handbrake
      mkvtoolnix
      mediainfo-gui
      testing.qmplay2
      mpv-git
      mousai
      subtitleedit

      # Games
      pcsx2
      libstrangle
      lutris

      # Office
      libreoffice-qt
      simple-scan
      foliate

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
      #ventoy-full
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
      nil
      gh
      trash-cli
      nixos-generators
      inxi
      iwmenu
      msedit
      nix-output-monitor
      lixPackageSets.latest.nix-fast-build
      delta
      glow
      autorestic
      restic

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
      rsync
      nix-prefetch
      nix-prefetch-git
      nix-prefetch-scripts
      mission-center
      nemo-with-extensions
      peazip
      picom
      gsmartcontrol
      freefilesync

      # System components
      nixd
      polkit
      plasma-hud
      exfat
      rar
      unixtools.quota
      polkit
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
      xfce.xfce4-xkb-plugin
      xfce.xfce4-alsa-plugin
      gvfs
      xfce.thunar
      xfce.thunar-volman
      stilo-themes
      package-version-server
      firefoxpwa
      kdePackages.kde-gtk-config
      run0-sudo-shim
    ];
  };

  services = {
    cinnamon.apps.enable = false; # Cinnamon apps
    gnome.gnome-keyring.enable = true; # Gnome keyring support
    usbmuxd.enable = true; # Usbmuxd support
    quake3-server = {
      enable = false;
      baseq3 = "/home/ulad/.wine/drive_c/GOG Games/Quake III/baseq3";
    };
    gvfs.enable = true;
    blueman.enable = true;
    gpm.enable = true;
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
    system-config-printer.enable = true;
  };

}
