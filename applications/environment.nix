{ inputs, outputs, lib, config, pkgs, ... }:
{
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
  
  # System apps
  libsForQt5.ark
  far2l
  krusader
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
];
}


