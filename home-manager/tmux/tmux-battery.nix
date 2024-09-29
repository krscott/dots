{ pkgs }:
pkgs.tmuxPlugins.battery.overrideAttrs (prev: {
  version = "unstable-2024-09-29";
  src = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-battery";
    rev = "48fae59ba4503cf345d25e4e66d79685aa3ceb75";
    sha256 = "sha256-yKMTuRiNnGC3tAbZeWzMEudzhBSJhji8sZh96rFxpb8=";
  };
})
