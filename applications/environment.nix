{ inputs, outputs, lib, config, pkgs, ... }:

{

nixpkgs = {
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
  cudatext
  lite-xl
  lapce
  kate
  eclipses.eclipse-java
  github-desktop
  nodejs
  nodePackages.gulp
  
  # Graphics
  gpick
  krita
  pinta
  qimgv
  blanket
  
  # Internet
  aria2
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
  python39Packages.secretstorage
  s-tui
  xsensors
  ventoy-bin
  bluetooth_battery
  scrcpy
  wl-clipboard
  wl-clipboard-x11
  
  # System apps
  libsForQt5.ark
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
  libsForQt5.bismuth
  rar
  unixtools.quota
  polkit
  papirus-maia-icon-theme
  luna-icons
  material-icons
  libplacebo
  python3Full
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
  firefox = {
    enable = true;
    preferences = {
      "browser.tabs.closeWindowWithLastTab" = false;
      "toolkit.tabbox.switchByScrolling" = true;
    };
  };
  gamemode.enable = true;
  gnome-disks.enable = true;
  xwayland.enable = true;
  mtr.enable = true;
  gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  ssh = {
  	askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
  	setXAuthLocation = false;
  };
};

}


