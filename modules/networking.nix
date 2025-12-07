# ==========================================
#  OSV MODULE — NETWORKING
# ==========================================
#
# Core networking configuration for Onyx OSV. Provides
# NetworkManager and a default-on firewall with no ports
# opened by default.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Network manager
  # ─────────────────────────────────────────

  networking.networkmanager.enable = true;

  # ─────────────────────────────────────────
  #  Firewall
  # ─────────────────────────────────────────

  networking.firewall = {
    enable = true;

    # Hosts extend these as needed.
    allowedTCPPorts = lib.mkDefault [ ];
    allowedUDPPorts = lib.mkDefault [ ];
  };
}
