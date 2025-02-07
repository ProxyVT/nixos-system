{ lib, config, ... }: {

home.activation.linkDesktopFiles = lib.hm.dag.entryAfter ["installPackages"] ''
    if [ -d "${config.home.profileDirectory}/share/applications" ]; then
      rm -rf ${config.home.homeDirectory}/.local/share/applications
      mkdir -p ${config.home.homeDirectory}/.local/share/applications
      for file in ${config.home.profileDirectory}/share/applications/*; do
        ln -sf "$file" ${config.home.homeDirectory}/.local/share/applications/
      done
    fi
  '';

}
