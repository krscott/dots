{config, ...}: let
  nc = import ../fonts/nerd-char.nix {inherit config;};
in {
  programs.starship = {
    enable = true;
    settings = {
      username = {
        format = "[$user@]($style)";
        style_user = "purple";
      };
      hostname = {
        format = "[$hostname]($style)[:](bright-black) ";
        style = "purple";
      };
      directory = {
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
        style = "bright-black";
        symbol = "";
      };
      git_status = {
        ahead = nc "⇡" "^";
        behind = nc "⇣" "v";
        diverged = nc "⇕" "%";
        deleted = nc "✘" "X";
      };
      package = {
        format = "[$symbol$version]($style) ";
        symbol = nc "󰏗 " "pkg ";
      };
      python = {
        symbol = nc " " "py ";
      };
      rust = {
        format = "[$symbol$version]($style) ";
        symbol = nc " " "rs ";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      status = {
        disabled = false;
        symbol = "";
      };
      container = {
        disabled = true;
      };
    };
  };
}
