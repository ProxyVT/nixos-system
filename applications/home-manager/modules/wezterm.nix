{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        scrollback_lines = 9999,
        enable_scroll_bar = true,
        freetype_load_flags = 'NO_HINTING',
        font = wezterm.font_with_fallback({
        'JetBrains Mono',
        'Noto Color Emoji'
        })
      }
    '';
  };
}
