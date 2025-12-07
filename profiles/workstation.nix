# ==========================================
#  OSV PROFILE — WORKSTATION
# ==========================================
#
# Opinionated defaults for a general-purpose workstation.
# Intended for desktop and laptop systems with a graphical
# environment. Can be combined with GPU modules as needed.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Printing and basic services
  # ─────────────────────────────────────────

  services.printing.enable = lib.mkDefault true;

  # ─────────────────────────────────────────
  #  Shell and tooling
  # ─────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    # Common workstation tools (safe to duplicate)
    neofetch
    tree
    ripgrep
    fd
    jq
    btop
  ];

  # ─────────────────────────────────────────
  #  Networking quality-of-life
  # ─────────────────────────────────────────

  programs.mtr.enable = lib.mkDefault true;
}
