
{
imports = [/home/umka/.nix-defexpr/channels/home-manager/nixos]; 
    home-manager.users.umka = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
  
    home.packages = with pkgs; [
      
    eclipses.eclipse-java
    github-desktop
    handbrake
    keeweb
    krita
    libreoffice-fresh
    mkvtoolnix
    mpv-unwrapped
    pinta
    qimgv
    scrcpy
    steam
    tdesktop
    ventoy-bin
    vivaldi
    yt-dlp
    qrcp
    ];
    
    programs = {
    
    bash.enable = true;
    home-manager.enable = true; 
    };
       
           
    };
  
}  
