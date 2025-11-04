{ ... }:
{
  programs.ssh = {
    knownHosts = {
      nixbuild = {
        hostNames = [ "eu.nixbuild.net" ];
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
      };
      astra = {
        hostNames = [ "91.219.236.45" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCRSrn1yS6py0RHwEWn+fc+xIwPCGWOrpBU7tXSWmGGrXiSvrBJfOgn5prKJoK8N+mEtWX/rTS6UOGSLe2WreIRoKgXQHDJsgwWCoUX+WpDoNpZGQBMp9hEtPV9lvcRDABpFOxdL5qYrLfKl+j19sovy5ma/Asb0tBRWiZSmN84pnzFELiEuGkLobJ/lZXD+OO4WkQm52RQLLPNqPVLXXH9C8h/Dkv147YSamVFn+2TQ2VeiG4BqT7UFH1KQjK0ULu4ospEAruGIws5s0jwRzXe4IDvmsiA74L8HI2erpwF/CRjnEBfPj9DOTtMPoUuVMDvvdVYAMcD+9a49Z5+u+oqh7s2RvdtaEQdvUa1jH3kX2ivbCmlW4VHdb035Gqfo3nAFd6ruVgQbMLhKzL41+sRKuGLmnPdZIaIl8otEDVOkTgSSU94sBQ4gIBRBAy1+PRWj6ko9WLmC7hHaVkNccG4Oke66EqLa0RzbGII/oGkciSdISJZ0e7lAsMi7IiRpf0=";
      };
    };
  };
}
