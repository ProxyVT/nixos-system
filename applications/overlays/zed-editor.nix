  { inputs, outputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        zed-git = prev.zed-editor.overrideAttrs (oldAttrs: rec {
          pname = "zed";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/zed-industries/zed.git";
            rev = "f45af17fd473746c82df851cda8cdd6923258701";
            hash = "sha256-8bBegGZjmmFTDVCRPWtsfFRD9r6pUir/24PIFn22FIU=";
          };
        });
      })
    ];
  };
}

