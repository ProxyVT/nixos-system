{ ... }:
{

  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/transmission"
      "/var/lib/resilio-sync"
      "/var/lib/iwd"
      "/etc/NetworkManager/system-connections"
      "/etc/mullvad-vpn"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];

    files = [
      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];

    users.ulad = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        "Sync"
        "nixos-system"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".config"
        ".local"
        ".mozilla"
        ".thunderbird"
        ".cache/thumbnails"
        ".cache/nix"
        ".cache/fontconfig"
        ".wine"
        ".wind"
      ];
      files = [
        ".screenrc"
        ".bash_history"
      ];
    };
  };

}
