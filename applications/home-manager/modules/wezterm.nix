{ ... }: {

programs.wezterm = {
  enable = false;
  extraConfig = ''
    return {
      enable_scroll_bar=true
    }
  '';
};

}
