{ extraPkgs, ... }:
{
  programs.nh = {
    enable = true;
    package = extraPkgs.nh;
    flake = "/home/ulad/nixos-system";
  };

  environment.shellAliases = {
    nh-boot = "nh os boot --diff always --ask --keep-going --hostname";
    nh-switch = "nh os switch --diff always --ask --keep-going --hostname";
    nh-build = "nh os build --diff always --keep-going --hostname";
  };
}
