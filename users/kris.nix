{...}: let
  username = "kris";
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  programs.git = {
    userEmail = "kscott91@gmail.com";
    userName = "Kris Scott";
  };
}
