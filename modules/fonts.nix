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
  fonts = {
    enableDefaultPackages = true;

    # ───────────────────────────────────────
    #  Font packages
    # ───────────────────────────────────────
    #
    # Notes:
    #   - Nerd Fonts are included only if available in the
    #     current nixpkgs (pkgs ? nerdfonts).
    #

    packages =
      let
        nerdFonts =
          lib.optional (pkgs ? nerdfonts)
            (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; });
      in
      (with pkgs; [
        # UI / text
        inter
        noto-fonts
        noto-fonts-cjk-sans
        dejavu_fonts

        # Monospace / development
        jetbrains-mono
        fira-code

        # Emoji / symbol coverage
        noto-fonts-color-emoji
        twemoji-color-font

        # Icon fonts for applets, quickshell, etc.
        font-awesome
        material-icons
        material-design-icons
      ]) ++ nerdFonts;

    # ───────────────────────────────────────
    #  Fontconfig defaults
    # ───────────────────────────────────────

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
