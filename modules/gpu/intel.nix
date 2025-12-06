# ==========================================
#  GPU MODULE — INTEL (iGPU)
# ==========================================
#
# This module provides configuration for systems using Intel
# integrated graphics. Import this module from a host
# configuration to enable Intel iGPU support.
#
# Notes:
#   - Only one GPU module should be active at a time.
#   - Uses the modesetting driver, recommended for modern Intel.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Driver selection
  # ─────────────────────────────────────────
  #
  # The modesetting driver is preferred for contemporary Intel GPUs.
  # NixOS typically selects it automatically, but the declaration
  # is made explicit for consistency with other GPU modules.

  services.xserver.videoDrivers = [ "modesetting" ];

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

  environment.systemPackages = with pkgs; [
    vulkan-tools      # vulkaninfo
    mesa-demos        # glxinfo, glxgears
    intel-gpu-tools   # intel_gpu_top, debugging suite
  ];

  # ─────────────────────────────────────────
  #  Optional kernel parameters
  # ─────────────────────────────────────────
  #
  # These may be useful for addressing specific i915 driver issues.
  #

  # boot.kernelParams = [
  #   "i915.enable_psr=0"
  # ];
}
