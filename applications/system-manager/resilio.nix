{ ... }: {

    services.resilio = {
      enable = false;
      enableWebUI = true;
      httpListenPort = 8888;
      httpListenAddr = "0.0.0.0";
    };

}
