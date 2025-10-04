{ ... }:

{
  services.mealie = {
    enable = true;

    settings = {
      ALLOW_SIGNUP = "false";
    };
  };
}
