{ ... }:
{

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "69ea3a262ffdbc9ff45270f2270a15fdb34e2d16";
            hash = "sha256-gfphv7phuHIfh6BmCkRtVMCw53BvHOrXpWdIDkZp5V8=";
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
