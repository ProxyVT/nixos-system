{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  vala,
  pkg-config,
  alsa-lib,
  ninja,
  gettext,
  xfce4-dev-tools,
  gtk3,
  xfce4-panel,
  libxfce4ui,
  libxfce4util,
  gitUpdater,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xfce4-alsa-plugin";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "equeim";
    repo = "xfce4-alsa-plugin";
    rev = finalAttrs.version;
    hash = "sha256-95uVHDyXji8dut7qfE5V/uBBt6DPYF/YfudHe7HJcE8=";
  };

  nativeBuildInputs = [
    meson
    vala
    pkg-config
    alsa-lib
    ninja
    gettext
    xfce4-dev-tools
    gtk3
  ];

  buildInputs = [
    gtk3
    xfce4-panel
    libxfce4ui
    libxfce4util
  ];

  passthru.updateScript = gitUpdater {
    url = "https://github.com/equeim/xfce4-alsa-plugin";
    rev-prefix = "xfce4-alsa-plugin-";
  };

  meta = with lib; {
    homepage = "https://github.com/equeim/xfce4-alsa-plugin";
    description = "Simple ALSA volume control for xfce4-panel";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ProxyVT ];
    teams = [ teams.xfce ];
  };
})
