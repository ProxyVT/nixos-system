{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    # ./nvim.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "ulad";
  };

  services = {
    easyeffects.enable = false;
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
