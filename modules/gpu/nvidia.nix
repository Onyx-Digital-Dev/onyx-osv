# ==========================================
#  GPU MODULE — NVIDIA
# ==========================================
#
# This module provides the standard configuration for systems
# using NVIDIA discrete GPUs. Import this module from a host
# configuration to enable NVIDIA support.
#
# Notes:
#   - Only one GPU module should be active per system.
#   - PRIME / hybrid systems should use `nvidia-prime.nix`.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Driver selection (X11 / DRM)
  # ─────────────────────────────────────────
  #
  # Even on Wayland systems, this determines the underlying
  # kernel DRM driver.

  services.xserver.videoDrivers = [ "nvidia" ];

  # ─────────────────────────────────────────
  #  OpenGL / 32-bit support
  # ─────────────────────────────────────────

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ─────────────────────────────────────────
  #  NVIDIA driver configuration
  # ─────────────────────────────────────────

  hardware.nvidia = {
    modesetting.enable = true;

    # Power management features are available but disabled by default.
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # The proprietary module is the default and recommended.
    open = false;

    nvidiaSettings = true;

    # Driver package selection.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ─────────────────────────────────────────
  #  Kernel modules and parameters
  # ─────────────────────────────────────────

  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];

}
