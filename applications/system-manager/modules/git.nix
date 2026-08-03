{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
      lfs = {
        enable = true;
        enablePureSSHTransfer = true;
      };
      config = {
        user = {
          name = "ProxyVT";
          email = "tikit.us@outlook.com";
        };
        safe.directory = [ "/home/ulad/*" ];
      };
    };
    git-worktree-switcher.enable = true;
  };
}
