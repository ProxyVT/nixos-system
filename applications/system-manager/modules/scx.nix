{ pkgs, ... }:
{
  services.scx = {
    enable = true;
    package = pkgs.scx-full_git;
    scheduler = "scx_flash";
  };
}
