{ pkgs, ... }:
{
  services.n8n = {
    enable = false;
    package = pkgs.edge.n8n;
  };
}
