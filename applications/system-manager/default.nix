{ pkgs, lib, ... }:
{

  imports = (lib.filesystem.listFilesRecursive ./modules);

  fonts.packages = with pkgs; [
    ibm-plex
    inter
    jetbrains-mono
    liberation_ttf
    open-sans
    roboto
  ];

  environment = {
    systemPackages = with pkgs; [

      # Development
      cudatext-gtk
      ghostty
      github-desktop
      kiro
      lite-xl
      nixpkgs-review
      nodejs
      nodePackages.gulp
      nodePackages.pnpm
      super-productivity
      waveterm
      windterm
      wineWowPackages.unstableFull
      zed-editor_git

      # Graphics
      blanket
      gpick
      kdePackages.spectacle
      krita
      pinta

      # Internet
      betterdiscord-installer
      browsh
      discord
      element-desktop
      epiphany
      kdePackages.ktorrent
      media-downloader
      motrix
      persepolis
      release.skypeexport
      skype.skypeforlinux
      telegram-desktop_git
      testing.ariang
      testing.vivaldi
      tor
      you-get

      # Server & security
      ddrescue
      ddrescueview
      electrum
      keepassxc
      sshuttle
      tradingview
      yandex-cloud
      yandex-disk

      # Multimedia
      audacity
      handbrake
      mediainfo-gui
      mkvtoolnix
      mousai
      mpv-git
      qmplay2
      subtitleedit

      # Games
      libstrangle
      lutris
      pcsx2

      # Office
      foliate
      libreoffice-qt
      simple-scan

      # CLI
      appimage-run
      autorestic
      bastet
      bluetooth_battery
      bottom
      brightnessctl
      broot
      ddcutil
      delta
      fastfetch
      ffmpeg_8-full
      ffmpeg-normalize
      fio
      gh
      glow
      inxi
      iwmenu
      lixPackageSets.latest.nix-fast-build
      lm_sensors
      msedit
      nil
      nix-output-monitor
      nix-tree
      nixfmt-rfc-style
      nixos-generators
      nurl
      psmisc
      python312Packages.secretstorage
      restic
      sbctl
      s-tui
      scrcpy
      speedtest-cli
      toybox
      trash-cli
      ttop
      tuifimanager
      vrrtest
      xsensors

      # System apps
      darkman
      freefilesync
      grsync
      gsmartcontrol
      mission-center
      monitorets
      nemo-with-extensions
      nix-prefetch
      nix-prefetch-git
      nix-prefetch-scripts
      pavucontrol
      peazip
      picom
      qdirstat
      qrcp
      resources
      rsync
      testdisk-qt
      xclip
      xournalpp
      yarn

      # System components
      bluez-alsa
      cmake
      exfat
      ffmpegthumbnailer
      firefoxpwa
      gcc
      glxinfo
      gst_all_1.gst-libav
      gst_all_1.gst-plugins-ugly
      gvfs
      ifuse
      kdePackages.kde-gtk-config
      libimobiledevice
      libva-utils
      material-icons
      nixd
      package-version-server
      plasma-hud
      polkit
      polkit
      python3Full
      rar
      stilo-themes
      unixtools.quota
      vulkan-tools
      wayland-utils
      xfce.thunar
      xfce.thunar-volman
      xfce.xfce4-alsa-plugin
      xfce.xfce4-xkb-plugin
      xorg.xdpyinfo
      xorg.xinit
    ];
  };

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    gpm.enable = true;
    gvfs.enable = true;
    usbmuxd.enable = true;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;
    gamemode.enable = true;
    gnome-disks.enable = true;
    localsend.enable = true;
    mtr.enable = true;
    npm.enable = true;
    openvpn3.enable = true;
    partition-manager.enable = true;
    system-config-printer.enable = true;
  };

}
