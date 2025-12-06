# ==========================================
#  OSV MODULE — MPD
# ==========================================
#
# Music Player Daemon configuration for Onyx OSV. Provides a
# local MPD instance and commonly used client tools.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  MPD service
  # ─────────────────────────────────────────

  services.mpd = {
    enable = true;
    musicDirectory = "/home/oskodiak/media/Audio";
    network.listenAddress = "127.0.0.1";
  };

  # ─────────────────────────────────────────
  #  MPD clients
  # ─────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    mpc
    ncmpcpp
  ];
}
