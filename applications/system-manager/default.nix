{
  pkgs,
  lib,
  ...
}:
{

  imports = (lib.filesystem.listFilesRecursive ./modules);

  fonts.packages = with pkgs; [
    ibm-plex
    inter
    jetbrains-mono
    liberation_ttf
    open-sans
    roboto
    nerd-fonts.bigblue-terminal
  ];

  environment = {
    systemPackages = with pkgs; [

      # Development
      cudatext-gtk
      github-desktop
      gitnuro
      lite-xl
      nodejs
      nodePackages.gulp
      nodePackages.pnpm
      super-productivity
      windterm
      wineWowPackages.unstableFull
      zed-editor_git
      tilix
      multios-usb

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
      telegram-desktop_git
      testing.ariang
      tor
      you-get

      # Server & security
      ddrescue
      ddrescueview
      electrum
      keepassxc
      sshuttle
      tradingview
      flood
      kdiskmark
      qdiskinfo

      # Multimedia
      audacity
      handbrake
      mediainfo-gui
      mkvtoolnix
      mousai
      qimgv
      qmplay2
      subtitleedit
      upscayl-ncnn
      upscayl

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
      bcachefs-tools
      bluetooth_battery
      bottom
      brightnessctl
      broot
      coreutils-full
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
      lm_sensors
      lshw
      msedit
      nil
      nixpkgs-lint
      nixpkgs-vet
      nixpkgs-reviewFull
      nixpkgs-track
      nixpkgs-pytools
      nix-output-monitor
      nix-tree
      nixfmt
      nixos-generators
      nurl
      psmisc
      python313Packages.secretstorage
      restic
      sbctl
      s-tui
      scrcpy
      speedtest-cli
      superfile
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
      krusader
      lshw-gui
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
      gcc
      gst_all_1.gst-libav
      gst_all_1.gst-plugins-ugly
      gvfs
      ifuse
      kdePackages.kde-gtk-config
      libimobiledevice
      libva-utils
      material-icons
      mesa-demos
      nixd
      package-version-server
      pciutils
      plasma-hud
      polkit
      polkit
      python3
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
      vivaldi-ffmpeg-codecs
    ];
  };

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    gpm.enable = true;
    gvfs.enable = true;
    usbmuxd.enable = true;
    flatpak.enable = true;
    flatpak.packages = [
      "eu.betterbird.Betterbird"
      "com.obsproject.Studio"
      "im.riot.Riot"
    ];
    n8n.enable = true;
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

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
