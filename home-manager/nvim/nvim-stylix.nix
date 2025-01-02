{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.krs.style.type == "stylix") {
    home.sessionVariables = with config.lib.stylix.colors; {
      STYLIX_BASE00 = "#${base00}";
      STYLIX_BASE01 = "#${base01}";
      STYLIX_BASE02 = "#${base02}";
      STYLIX_BASE03 = "#${base03}";
      STYLIX_BASE04 = "#${base04}";
      STYLIX_BASE05 = "#${base05}";
      STYLIX_BASE06 = "#${base06}";
      STYLIX_BASE07 = "#${base07}";
      STYLIX_BASE08 = "#${base08}";
      STYLIX_BASE09 = "#${base09}";
      STYLIX_BASE0A = "#${base0A}";
      STYLIX_BASE0B = "#${base0B}";
      STYLIX_BASE0C = "#${base0C}";
      STYLIX_BASE0D = "#${base0D}";
      STYLIX_BASE0E = "#${base0E}";
      STYLIX_BASE0F = "#${base0F}";
    };

    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        mini-base16
        transparent-nvim
      ];
    };
  };
}
