  { ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "7ad2ee495e74bf01990e2f709c1b5853fa02482d";
            hash = "sha256-yPRNnRG/je8k9I5jt+g6cCBp8T2R7aiqPWBJjR2SX9k=";
          };
          tools = prev.buildGoModule {
            pname = "uosc-bin";
            inherit version src;
            vendorHash = "sha256-oRXChHeVQj6nXvKOVV125sM8wD33Dxxv0r/S7sl6SxQ=";
          };
          patches = [];
        });
      })
    ];
  };
}
