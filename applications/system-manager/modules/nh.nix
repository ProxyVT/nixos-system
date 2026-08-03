{ inputs, pkgs, ... }:
{
  programs.nh = {
    enable = true;
    package = inputs.nh.packages.${pkgs.stdenv.hostPlatform.system}.default;
    flake = "/home/ulad/nixos-system";
  };

  environment.shellAliases = {
    nh-boot = "nh os boot --diff always --ask --keep-going --hostname";
    nh-switch = "nh os switch --diff always --ask --keep-going --hostname";
    nh-build = "nh os build --diff always --keep-going --hostname";
  };
}
