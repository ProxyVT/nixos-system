{ pkgs, config, outputs, modulesPath, ... }: {

imports = [
  "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
];

boot = {
  kernelPackages = pkgs.edge.linuxPackages_6_12;
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
};
nix = {
  settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
};
nixpkgs = {
  config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  hostPlatform = "x86_64-linux";
  overlays = [ outputs.overlays.packages ];
};
networking.networkmanager.enable = true;
i18n.defaultLocale = "en_GB.UTF-8";
services = {
  xserver = {                                         
    enable = true;
    desktopManager.budgie.enable = true;
    videoDrivers = [ "nvidia" ];
  };
};

}
