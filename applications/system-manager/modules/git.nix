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
        url = {
          "ssh://git@github.com/".insteadOf = "https://github.com/";
          "ssh://git@gitlab.com/".insteadOf = "https://gitlab.com/";
        };
        safe.directory = [ "/home/ulad/*" ];
      };
    };
    git-worktree-switcher.enable = true;
  };
}
