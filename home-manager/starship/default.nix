{ config, ... }:
let
  wc = import ../fonts/wide-char.nix { inherit config; };
in
{
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
        ahead = wc "⇡";
        behind = wc "⇣";
        diverged = wc "⇕";
        deleted = wc "✘";
      };
      package = {
        format = "[$symbol$version]($style) ";
        symbol = wc "󰏗";
      };
      python = {
        symbol = wc "";
      };
      rust = {
        format = "[$symbol$version]($style) ";
        symbol = wc "";
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
