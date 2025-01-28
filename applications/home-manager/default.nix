{ ... }: {

imports = [
  ./aria2.nix
  ./bash.nix
  ./btop.nix
  ./firefox.nix
  ./mangohud.nix
  ./thunderbird.nix
  ./wezterm.nix
  ./yt-dlp.nix
  ./icon_fix.nix
];

nixpkgs = {
  config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);     # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
};

services = {
  easyeffects.enable = true;
  gpg-agent.enable = true;
};

programs = {
  home-manager.enable = true;
  java.enable = true;
  chromium.enable = true;
  gpg.enable = true;
};

home.stateVersion = "24.05";

}
