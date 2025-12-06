# ==========================================
#  GPU MODULE — AMD (AMDGPU)
# ==========================================
#
# This module provides configuration for systems using AMD GPUs
# via the amdgpu kernel driver. Import this module from a host
# configuration to enable AMD GPU support.
#
# Notes:
#   - Only one GPU module should be active at a time.
#   - Includes 32-bit graphics support for compatibility.
#   - Kernel parameters may assist legacy SI/CIK hardware.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Driver selection (X11 / DRM)
  # ─────────────────────────────────────────
  #
  # Even when running Wayland, this sets the DRM backend driver.

  services.xserver.videoDrivers = [ "amdgpu" ];

  # ─────────────────────────────────────────
  #  OpenGL / 32-bit support
  # ─────────────────────────────────────────

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ─────────────────────────────────────────
  #  Utilities
  # ─────────────────────────────────────────
  #
  # Useful for verifying Vulkan, OpenGL, and VA-API behavior.

  environment.systemPackages = with pkgs; [
    vulkan-tools      # vulkaninfo
    mesa-demos        # glxinfo, glxgears
    libva-utils       # vainfo
  ];

  # ─────────────────────────────────────────
  #  Kernel parameters (optional)
  # ─────────────────────────────────────────
  #
  # SI/CIK support flags assist certain older GPUs:
  #
  #   - Southern Islands (SI)
  #   - Sea Islands (CIK)
  #
  # On modern hardware these parameters are typically harmless,
  # but they remain enabled for broad compatibility.

  boot.kernelParams = [
    "amdgpu.si_support=1"
    "amdgpu.cik_support=1"
  ];
}
