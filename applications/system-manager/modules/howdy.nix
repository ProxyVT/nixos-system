{ ... }:
{
  services = {
    howdy = {
      enable = false;
      control = "optional";
    };
    linux-enable-ir-emitter.enable = true;
  };
}
