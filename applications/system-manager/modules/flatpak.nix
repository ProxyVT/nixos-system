{ ... }:
{
  services.flatpak = {
    enable = true;
    packages = [
      "eu.betterbird.Betterbird"
      "im.riot.Riot"
    ];
  };
}
