# ==========================================
#  OSV BASE MODULE — NIX SETTINGS
# ==========================================
#
# Central Nix and nixpkgs configuration for Onyx OSV. Controls
# flake support, store optimization, GC policy, and unfree
# packages.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Nixpkgs configuration
  # ─────────────────────────────────────────

  nixpkgs.config.allowUnfree = true;

  # ─────────────────────────────────────────
  #  Nix daemon / client settings
  # ─────────────────────────────────────────

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    max-jobs = "auto";
    cores = 0;

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    auto-optimise-store = true;
  };

  # ─────────────────────────────────────────
  #  Garbage collection
  # ─────────────────────────────────────────

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
