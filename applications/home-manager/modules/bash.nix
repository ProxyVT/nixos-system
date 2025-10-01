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
      nh-boot = "nh os boot --diff always --ask --keep-going --hostname";
      nh-switch = "nh os switch --diff always --ask --keep-going --hostname";
      nh-build = "nh os build --diff always --keep-going --hostname";
    };
  };
}
