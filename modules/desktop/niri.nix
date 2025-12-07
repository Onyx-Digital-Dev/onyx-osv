# ==========================================
#  OSV DESKTOP - NIRI STACK
# ==========================================
# New users:
#   - This module wires up Niri + the core Wayland stack.
#   - It assumes a display manager (e.g. SDDM) will start Niri.
#
# Advanced:
#   - Layer Home Manager on top for Niri config.kdl, Mako, swayidle, etc.

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Core compositor + XWayland
  # ─────────────────────────────────────────

  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # ─────────────────────────────────────────
  #  Bar (Waybar)
  # ─────────────────────────────────────────
  #
  # NixOS has a native waybar module.
  # HM can refine style/settings later if we want.

  programs.waybar.enable = true;

  # ─────────────────────────────────────────
  #  PAM integration for swaylock
  # ─────────────────────────────────────────
  #
  # Required so swaylock can actually unlock the session.

  security.pam.services.swaylock = { };

  # ─────────────────────────────────────────
  #  Portals, polkit, secret service
  # ─────────────────────────────────────────
  #
  # This is the big “make Wayland apps behave like a modern desktop” bit.

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # ─────────────────────────────────────────
  #  Packages Niri expects around it
  # ─────────────────────────────────────────
  #
  # Full feature *foundation* on the system side.
  # Behavior/autostart will be handled later by Home Manager.

  environment.systemPackages = with pkgs; [
    # Core Wayland workflow
    alacritty
    fuzzel
    swaylock
    swaybg
    wl-clipboard
    grim
    slurp

    # Notifications + idle (packages only; HM will manage services)
    mako
    swayidle

    # Niri-recommended helper
    xwayland-satellite

    # Portals / keyring UX
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
    polkit_gnome

    # Optional: GNOME file chooser that xdg-desktop-portal-gnome prefers
    nautilus
  ];

  # ─────────────────────────────────────────
  #  Wayland / Electron quirks
  # ─────────────────────────────────────────
  #
  # Helps Chromium/Electron apps prefer Wayland.

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
