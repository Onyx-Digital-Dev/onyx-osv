# ==========================================
#  OSV MODULE — FONTS
# ==========================================
#
# Font configuration for Onyx OSV systems. Provides a set of
# commonly used font families and enables the default NixOS
# font packages.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Font packages
  # ─────────────────────────────────────────

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      inter
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      jetbrains-mono
      dejavu_fonts
      font-awesome
      material-icons
      material-design-icons
    ];
  };
}
