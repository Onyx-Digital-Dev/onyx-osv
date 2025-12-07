# ==========================================
#  GPU MODULE — NVIDIA PRIME (HYBRID)
# ==========================================
#
# This module provides configuration for systems with hybrid
# graphics (typically Intel + NVIDIA) using PRIME offloading.
#
# Usage:
#   - Import this module on laptops with integrated + NVIDIA GPU.
#   - Do not import any other GPU module at the same time.
#
# Notes:
#   - Offload mode is enabled by default.
#   - PRIME sync can be enabled if required by the hardware.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Driver selection
  # ─────────────────────────────────────────
  #
  # The NVIDIA driver is used for rendering in a PRIME setup.

  services.xserver.videoDrivers = [ "nvidia" ];

  # ─────────────────────────────────────────
  #  OpenGL / 32-bit support
  # ─────────────────────────────────────────

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ─────────────────────────────────────────
  #  NVIDIA PRIME configuration
  # ─────────────────────────────────────────
  #
  # Offloading:
  #   - Renders on the NVIDIA GPU and presents via the iGPU.
  #   - Commonly used with wrapper commands such as:
  #       `nvidia-offload <program>`

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # The proprietary module is the default and recommended.
    open = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      # sync.enable = true;  # Alternative mode; enable if required.
    };
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
