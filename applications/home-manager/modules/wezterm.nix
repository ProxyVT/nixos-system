{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        enable_scroll_bar=true
      }
    '';
  };
}
