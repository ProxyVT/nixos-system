{ ... }:
{
  services.opentelemetry-collector = {
    enable = false;
    settings = {
      receivers = {
        otlp.protocols.http.endpoint = "127.0.0.1:4318";
      };
      exporters = {
        "otlp_http/honeycomb" = {
          endpoint = "https://api.honeycomb.io";
          headers = {
            "x-honeycomb-team" = "hcamk_01m4kcwp27h5yjbtc6h8t72kzh";
            "x-honeycomb-dataset" = "nix-builds";
          };
        };
      };
      service.pipelines.traces = {
        receivers = [ "otlp" ];
        exporters = [ "otlp_http/honeycomb" ];
      };
    };
  };
}
