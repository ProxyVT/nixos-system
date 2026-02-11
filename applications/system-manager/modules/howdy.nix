{ ... }:
{
  services = {
    howdy = {
      enable = true;
      control = "optional";
    };
    linux-enable-ir-emitter.enable = true;
  };
}
