# ==========================================
#  OSV DESKTOP - NIRI STACK
# ==========================================
# New users:
#   - This module wires up Niri + the core Wayland stack.
#   - It assumes a display manager (e.g. SDDM) will start Niri.
#
# Advanced:
#   - Layer Home Manager on top for niri/config.kdl and keybinds.

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Core compositor
  # ─────────────────────────────────────────

  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # ─────────────────────────────────────────
  #  Bar + notifications + idle + lock
  # ─────────────────────────────────────────
  #
  # Matches NixOS wiki “Additional Setup” and Niri wiki “Important Software”.
  # - alacritty   : default terminal in upstream config
  # - fuzzel      : app launcher
  # - swaylock    : lockscreen
  # - waybar      : top bar
  # - mako        : notification daemon
  # - swayidle    : idle management

  programs.waybar.enable = true;

  programs.mako.enable = true;

  services.swayidle = {
    enable = true;
    # Safe defaults; tweak per-host if you want suspend, etc.
    timeouts = [
      {
        timeout = 600; # 10 minutes
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      # {
      #   timeout = 900;
      #   command = "${pkgs.systemd}/bin/systemctl suspend";
      # }
    ];
  };

  # Allow swaylock to use PAM
  security.pam.services.swaylock = { };

  # ─────────────────────────────────────────
  #  Portals, polkit, secret service
  # ─────────────────────────────────────────
  #
  # Upstream recommends:
  #   - xdg-desktop-portal-gtk  (fallback / generic)
  #   - xdg-desktop-portal-gnome (screencast)
  #   - gnome-keyring (Secret Service)
  #
  # NixOS’ xdg.portal module handles the systemd wiring.

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    # We can leave .config.common.default alone and let NixOS pick.
    # If we ever want to explicitly prefer GNOME or GTK we can set it here.
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # ─────────────────────────────────────────
  #  Wayland helpers & Niri-recommended tools
  # ─────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    # Terminal / launcher / lock / wallpaper / clipboard / screenshots
    alacritty
    fuzzel
    swaylock
    swaybg
    wl-clipboard
    grim
    slurp

    # XWayland helper strongly recommended by upstream Niri docs
    xwayland-satellite

    # Portals & secrets
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring

    # Polkit agent (you’ll autostart per-user via Niri or user systemd)
    polkit_gnome

    # Optional:
    #   nautilus is what xdg-desktop-portal-gnome prefers as file chooser.
    #   Comment this out if you really don’t want it and instead ship
    #   a custom niri-portals.conf pointing file chooser at GTK instead.
    nautilus
  ];

  # ─────────────────────────────────────────
  #  Wayland / Electron quirks
  # ─────────────────────────────────────────
  #
  # Helps Electron/Chromium stuff behave on Wayland (Slack, VS Code, etc.).

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
