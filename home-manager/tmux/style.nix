{
  config,
  pkgs,
  ...
}: let
  nc = import ../fonts/nerd-char.nix {inherit config;};
in {
  # Using custom tweaks that interfere with the default config
  config = {
    catppuccin.tmux.enable = false;

    programs.tmux.plugins =
      if (config.krs.style.type == "catppuccin")
      then [
        {
          plugin = pkgs.tmuxPlugins.catppuccin;
          extraConfig = let
            battery =
              if config.krs.system.hasBattery
              then "battery"
              else "";
          in ''
            set -g @catppuccin_status_modules_right "application session ${battery} date_time"
            set -g @catppuccin_flavour 'mocha' # latte, frappe, macchiato, mocha
            # Make tabs display window name instead of default (current directory)
            set -g @catppuccin_window_default_text "#W"
            set -g @catppuccin_window_current_text "#W"
            set -g @catppuccin_status_left_separator "${nc "" "█"}"
            set -g @catppuccin_application_icon "${nc "" "$"}"
            set -g @catppuccin_session_icon "${nc "" ">"}"
          '';
        }
        (import ../tmux/tmux-battery.nix {inherit pkgs;}) # load after catppuccin
      ]
      else [
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
