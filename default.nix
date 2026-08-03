let
  ulad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGulTWx70ryRRxPLUjGW951k5MYVkMY91DZACpnJYF/+ ulad@nixos";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKIC4FKvCytVKkrsmOCC3S8BG+ziwK5O04jRyah7qU8s root@nixos";
in
{
  "default.age".publicKeys = [ ulad system ];
}
