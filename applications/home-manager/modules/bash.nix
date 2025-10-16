{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      sudo = "run0";
      nix-gc = "run0 nix-collect-garbage -d ; nix-collect-garbage -d";
      boot = "run0 nixos-rebuild boot --flake";
      switch = "run0 nixos-rebuild switch --flake";
      build = "nixos-rebuild build --flake";
    };
  };
}
