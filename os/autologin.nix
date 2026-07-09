{ username, ... }:

{
  services.getty = {
    autologinUser = username;
    autologinOnce = true;
  };

}
