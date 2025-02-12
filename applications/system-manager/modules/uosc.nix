{ ... }: {

nixpkgs = {
  overlays = [
    (final: prev: {
      uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
        pname = "uosc";
        version = "git";
        src = prev.fetchgit {
          url = "https://github.com/tomasklaen/uosc.git";
          rev = "370588a9676817df0585eacb5b8ac7ecda3c9007";
          hash = "sha256-NveOFs56NycLZq2+BTdv9GIwgVQxtFm3ZKdbHGkW6sY=";
        };
        tools = prev.buildGoModule {
          pname = "uosc-bin";
          inherit version src;
          vendorHash = "sha256-oRXChHeVQj6nXvKOVV125sM8wD33Dxxv0r/S7sl6SxQ=";
        };
        patches = [ ];
      });
    })
  ];
};

}
