{
  config,
  lib,
  pkgs,
  ...
}: let
  nc = import ../fonts/nerd-char.nix {inherit config;};
in {
  imports = [
    ./catppuccin.nix
    ./stylix.nix
  ];

  config = {
    # Stylix creats a lazygit config, which fails if lazygit already created
    # one at runtime.
    # Create a blank file from nix to keep lazygit from creating one itself.
    xdg.configFile."lazygit/config.yml".text = "";

    programs.tmux.plugins = lib.mkIf (config.krs.theme.type != "catppuccin") [
      {
        plugin = import ../tmux/tmux-battery.nix {inherit pkgs;};
        extraConfig = let
          battery =
            if config.krs.system.hasBattery
            then "${nc "#{battery_icon}" ""} #{battery_percentage} " # "#{battery_remain}"
            else "";
        in ''
          # From catppuccin battery.conf
          set -ogq @batt_icon_charge_tier8 "󰁹"
          set -ogq @batt_icon_charge_tier7 "󰂁"
          set -ogq @batt_icon_charge_tier6 "󰁿"
          set -ogq @batt_icon_charge_tier5 "󰁾"
          set -ogq @batt_icon_charge_tier4 "󰁽"
          set -ogq @batt_icon_charge_tier3 "󰁼"
          set -ogq @batt_icon_charge_tier2 "󰁻"
          set -ogq @batt_icon_charge_tier1 "󰁺"
          set -ogq @batt_icon_status_charged "󰚥"
          set -ogq @batt_icon_status_charging "󰂄"
          set -ogq @batt_icon_status_discharging "󰂃"
          set -ogq @batt_icon_status_unknown "󰂑"
          set -ogq @batt_icon_status_attached "󱈑"

          # Set background transparent
          set -g status-style bg=default,fg=white

          set -g status-left ""

          set -g window-status-format "#[fg=brightblack] #I #[fg=white]#W #[default]"
          set -g window-status-current-format "#[fg=brightblack,bg=white] #I #[fg=black]#W #[default]"
          set -g window-status-separator ""

          set -g status-right "#[fg=grey]${nc " #S" "[#S]"} ${battery}%a %h-%d %H:%M "
        '';
      }
    ];
  };
}
