{ ... }:
{
  imports = [
    ./home.nix
  ];

  programs.git = {
    userEmail = "kscott91@gmail.com";
    userName = "Kris Scott";
  };
}
