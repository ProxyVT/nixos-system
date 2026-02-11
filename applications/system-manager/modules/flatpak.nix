{ ... }:
{
  services.flatpak = {
    enable = true;
    packages = [
      "eu.betterbird.Betterbird"
      "com.obsproject.Studio"
      "im.riot.Riot"
    ];
  };
}
