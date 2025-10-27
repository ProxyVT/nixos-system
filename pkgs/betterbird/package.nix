# To enable traysupport,set mail.biff.show_tray_icon_always to true in about:config
# To enable globalmenu: set widget.gtk.global-menu.wayland.enabled to true in about:config, and enable 'use system title bar'
{
  pkgs,
  lib,
  buildMozillaMach,
  cacert,
  fetchFromGitHub,
  fetchurl,
  git,
  libdbusmenu-gtk3,
  runtimeShell,
  thunderbirdPackages,
}:
let
  thunderbird-unwrapped = thunderbirdPackages.thunderbird-140;
  # Globalmenu in kde/gnome, https://github.com/Lexi-Ewald/unity-menubar
  unityMenubar = fetchurl {
    url = "https://raw.githubusercontent.com/Lexi-Ewald/unity-menubar/e8dbaf63201165631edb12aac679d45eb970edf7/unity-menubar.patch";
    sha256 = "sha256-PYD6vQLq5FXjbX5vHnDPY0UGpjteq+YHTfWCTnatKFM=";
  };
  version = "140.2.1esr";
  majVer = lib.versions.major version;
  betterbird-patches = fetchFromGitHub {
    owner = "Betterbird";
    repo = "thunderbird-patches";
    rev = "${version}-bb10";
    hash = "sha256-LuV/42sivTIXILecyKUsFQFeUB7goxSdUFB0NvQl4/M=";
    postFetch = ''
      echo "Retrieving external patches"
      echo "#!${runtimeShell}" > external.sh
      # if no external patches need to be downloaded, don't fail
      { grep " # " $out/${majVer}/series-moz || true ; } >> external.sh
      { grep " # " $out/${majVer}/series || true ; } >> external.sh
      sed -i -e '/^#/d' external.sh
      sed -i -e 's/\/rev\//\/raw-rev\//' external.sh
      sed -i -e 's|\(.*\) # \(.*\)|curl -L \2 -o $out/${majVer}/external/\1|' external.sh
      chmod 700 external.sh
      mkdir $out/${majVer}/external
      SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
      cp ${unityMenubar} "$out/${majVer}/features/unity-menubar-142.patch"
      echo 'unity-menubar-142.patch' >> $out/${majVer}/series-moz
      . ./external.sh
    '';
  };
in
(
  (buildMozillaMach {
    pname = "betterbird";
    inherit version;
    applicationName = "Betterbird";
    binaryName = "betterbird";
    branding = "comm/mail/branding/betterbird";
    inherit (thunderbird-unwrapped) extraPatches;

    src = fetchurl {
      # https://download.cdn.mozilla.net/pub/thunderbird/releases/
      url = "mirror://mozilla/thunderbird/releases/${version}/source/thunderbird-${version}.source.tar.xz";
      hash = "sha256-yeS5j3LbPpCE3Hq+XwzPCb/D4vMncGNx26TC7goUwps=";
    };

    extraPostPatch =
      # bash
      ''
        set -euo pipefail
        PATH=$PATH:${lib.makeBinPath [ git ]}

        patches=$(mktemp -d)
        for dir in branding bugs external features misc; do
          cp -f ${betterbird-patches}/${majVer}/$dir/*.patch "$patches/" 2>/dev/null || true
        done
        cp -f ${betterbird-patches}/${majVer}/series* "$patches/" 2>/dev/null || true
        chmod -R u+w "$patches"

        # Fix include paths in systray patch
        if [ -f "$patches/12-feature-linux-systray.patch" ]; then
          substituteInPlace "$patches/12-feature-linux-systray.patch" \
            --replace-fail "/usr/include/libdbusmenu-glib-0.4/" "${lib.getDev libdbusmenu-gtk3}/include/libdbusmenu-glib-0.4/" \
            --replace-fail "/usr/include/libdbusmenu-gtk3-0.4/"  "${lib.getDev libdbusmenu-gtk3}/include/libdbusmenu-gtk3-0.4/"
        fi

        # Normalize series lines: (Don't know if this is needed, but some branding patches kept getting skipped)
        normalize_series() {
          sed -E 's/#.*$//; s/^[[:space:]]+//; s/[[:space:]]+$//' "$1" | sed '/^$/d'
        }

        # Patches to skip
        skip_patch() {
          case "$1" in
            14-feature-regexp-searchterm.patch|\
            14-feature-regexp-searchterm-m-c.patch|\
            feature-506064-match-diacritics.patch)
              return 0 ;;
            *)  return 1 ;;
          esac
        }

        apply_patch_root() {
          echo ">> applying (m-c) $1"
          test -f "$patches/$1" || { echo "!! missing patch: $1" >&2; exit 1; }
          git apply -p1 -v < "$patches/$1"
        }

        apply_patch_comm() {
          echo ">> applying (c-c) $1"
          test -f "$patches/$1" || { echo "!! missing patch: $1" >&2; exit 1; }
          git apply -p1 -v --directory=comm < "$patches/$1"
        }

        # Apply m-c patches first
        if [ -f "$patches/series-moz" ]; then
          normalize_series "$patches/series-moz" | while IFS= read -r p; do
            if skip_patch "$p"; then
              echo ">> skipping $p"
              continue
            fi
            apply_patch_root "$p"
          done
        fi

        # Then c-c patches
        if [ -f "$patches/series" ]; then
          normalize_series "$patches/series" | while IFS= read -r p; do
            if skip_patch "$p"; then
              echo ">> skipping $p"
              continue
            fi
            apply_patch_comm "$p"
          done
        # copy Betterbird mozconfig
        cp -f ${betterbird-patches}/${majVer}/mozconfig-Linux mozconfig
        fi
      '';

    extraBuildInputs = [
      libdbusmenu-gtk3
    ];

    meta = with lib; {
      description = "Betterbird is a fine-tuned version of Mozilla Thunderbird, Thunderbird on steroids, if you will";
      homepage = "https://www.betterbird.eu/";
      mainProgram = "betterbird";
      maintainers = with maintainers; [ dp ];
      inherit (thunderbird-unwrapped.meta) platforms broken license;
    };
  }).override
  {
    crashreporterSupport = false; # not supported
    geolocationSupport = false;
    webrtcSupport = false;
    pgoSupport = false; # console.warn: feeds: "downloadFeed: network connection unavailable"

    inherit (thunderbird-unwrapped.passthru) icu77;
  }
).overrideAttrs
  (oldAttrs: {
    # let betterbird mozconfig handle configure, only add libclang
    configureFlags = [ ] ++ [
      "--with-libclang-path=${lib.getLib pkgs.llvmPackages.libclang}/lib"
      "--with-distribution-id=org.nixos"
      "--disable-updater"
    ];
    # show build errors
    MOZ_MAKE_FLAGS = "-j$NIX_BUILD_CORES V=1";
    # prevent nounset crash
    dontWrapGApps = true;
    nativeBuildInputs =
      let
        base = oldAttrs.nativeBuildInputs or [ ];
      in
      (builtins.filter (x: x != pkgs.wrapGAppsHook && x != pkgs.makeBinaryWrapper) base)
      ++ [ pkgs.makeWrapper ];

    postInstall = oldAttrs.postInstall or "" + ''
      if file "$out/lib/betterbird/betterbird" | grep -q ELF; then
        mv "$out/lib/betterbird/betterbird" "$out/lib/betterbird/betterbird-bin"
      fi

      mv $out/lib/thunderbird/* $out/lib/betterbird
      rmdir $out/lib/thunderbird/
      rm $out/bin/thunderbird
      # Desktop file
      mkdir -p "$out/share/applications"
      cat > "$out/share/applications/eu.betterbird.Betterbird.desktop" <<'EOF'
        [Desktop Entry]
        Type=Application
        Name=Betterbird
        Comment=Fine-tuned Thunderbird
        Exec=betterbird %u
        Icon=betterbird
        Terminal=false
        Categories=Network;Email;
        MimeType=x-scheme-handler/mailto;x-scheme-handler/webcal;text/calendar;
        StartupWMClass=eu.betterbird.Betterbird
      EOF

      # Icons
      for s in 64 128; do
        if [ -f "comm/mail/branding/betterbird/content/icon"''${s}".png" ]; then
          install -Dm644 "comm/mail/branding/betterbird/content/icon"''${s}".png" \
          "$out/share/icons/hicolor/"''${s}"x"''${s}"/apps/betterbird.png"
        fi
      done
    '';

    # 4) Wrap manually, cant get the GApps magic working
    postFixup = (oldAttrs.postFixup or "") + ''

       # Build runtime lib path
       LD_PATH="${
         lib.makeLibraryPath [
           pkgs.libglvnd
           pkgs.libdrm
           pkgs.pciutils
           pkgs.wayland
           pkgs.libxkbcommon
           pkgs.xorg.libX11
           pkgs.xorg.libXcursor
           pkgs.xorg.libXrandr
           pkgs.xorg.libXdamage
           pkgs.xorg.libXcomposite
           pkgs.gtk3
           pkgs.glib
           pkgs.pango
           pkgs.cairo
           pkgs.freetype
           pkgs.fontconfig
           pkgs.nss
           pkgs.nspr
           pkgs.dbus
           pkgs.glib-networking
           pkgs.libdbusmenu-gtk3
         ]
       }"

      XDG_DIRS="$out/share:${pkgs.gsettings-desktop-schemas}/share:${pkgs.gtk3}/share:${pkgs.adwaita-icon-theme}/share:${pkgs.hicolor-icon-theme}/share"

      makeWrapper "$out/lib/betterbird/betterbird-bin" "$out/bin/betterbird" \
      --set MOZ_ENABLE_WAYLAND 1 \
      --set GTK_USE_PORTAL 1 \
      --set MOZ_DBUS_REMOTE 1 \
      --set GTK_MODULES appmenu-gtk-module \
      --prefix GTK_PATH : "${pkgs.appmenu-gtk3-module}/lib/gtk-3.0" \
      --set GIO_EXTRA_MODULES "${pkgs.glib-networking}/lib/gio/modules" \
      --prefix XDG_DATA_DIRS : "$XDG_DIRS" \
      --prefix LD_LIBRARY_PATH : "$LD_PATH"
    '';

    doInstallCheck = false;

    passthru = oldAttrs.passthru // {
      inherit betterbird-patches;
    };
  })
