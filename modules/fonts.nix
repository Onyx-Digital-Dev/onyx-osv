# ==========================================
#  OSV MODULE — FONTS
# ==========================================
#
# Font configuration for Onyx OSV systems. Provides a curated
# set of UI, monospace, emoji, CJK, and icon fonts suitable
# for modern desktops, panels, and HUDs.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Font packages
  # ─────────────────────────────────────────
  #
  # Notes:
  #   - nerdfonts is restricted to a small set of families to
  #     avoid pulling the entire collection.
  #

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # UI / text
      inter
      noto-fonts
      noto-fonts-cjk-sans
      dejavu_fonts

      # Monospace / development
      jetbrains-mono
      fira-code

      # Nerd Fonts (for icons in terminals, bars, prompts)
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })

      # Emoji / symbol coverage
      noto-fonts-color-emoji
      twemoji-color-font

      # Icon fonts for applets, quickshell, etc.
      font-awesome
      material-icons
      material-design-icons
    ];

    # ───────────────────────────────────────
    #  Fontconfig defaults
    # ───────────────────────────────────────
    #
    # Sensible defaults for UI and terminal font families.
    #

    fontconfig.defaultFonts = lib.mkDefault {
      sansSerif = [
        "Inter"
        "Noto Sans"
        "DejaVu Sans"
      ];

      monospace = [
        "JetBrainsMono Nerd Font"
        "FiraCode Nerd Font"
        "DejaVu Sans Mono"
      ];

      emoji = [
        "Noto Color Emoji"
        "Twemoji"
      ];
    };
  };
}
