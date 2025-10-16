{ ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/ulad/nixos-system";
  };

  programs.bash.shellAliases = {
    nh-boot = "nh os boot --diff always --ask --keep-going --hostname";
    nh-switch = "nh os switch --diff always --ask --keep-going --hostname";
    nh-build = "nh os build --diff always --keep-going --hostname";
  };
}
