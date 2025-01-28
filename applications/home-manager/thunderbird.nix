{ pkgs, ... }: {

programs.thunderbird = {
  enable = true;
  package = pkgs.thunderbird;
  profiles.ulad = {
    isDefault = true;
  };
};

}
