{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.krs.cloudAi.enable {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        # codeium-nvim
        ChatGPT-nvim

        nui-nvim # required by ChatGPT-nvim
      ];

      # extraPackages = with pkgs; [
      #   codeium
      # ];
    };
  };
}
