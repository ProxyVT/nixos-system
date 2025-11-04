{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        enable_scroll_bar = true,
        freetype_load_flags = 'NO_HINTING',
        font = wezterm.font_with_fallback({
        'BigBlueTermPlus Nerd Font Mono',
        'JetBrains Mono',
        'Noto Color Emoji'
        })
      }
    '';
  };
}
