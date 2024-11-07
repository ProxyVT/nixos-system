{ ... }: {

  programs.bash = {
    enable = true;
    shellAliases = {
      sudo = "doas";
      nix-gc = "doas nix-collect-garbage -d ; nix-collect-garbage -d";
      boot = "doas nixos-rebuild boot --flake";
      switch = "doas nixos-rebuild switch --flake";
      build = "nixos-rebuild build --flake";
    };
  };

}
