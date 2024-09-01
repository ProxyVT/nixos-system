{ lib, config, pkgs, ... }: {

programs.ssh = {
  knownHosts = {
    nixbuild = {
      hostNames = [ "eu.nixbuild.net" ];
      publicKey = "sh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7V1q5kKup+eSTkqpcsb7qqoKcb8V9foiZGF6dn4qqE";
    };
  };
  extraConfig = ''
    Host eu.nixbuild.net
      PubkeyAcceptedKeyTypes ssh-ed25519
      ServerAliveInterval 60
      IPQoS throughput
      IdentityFile /home/ulad/my-nixbuild-key
  '';
};

}
