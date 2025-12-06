# ==========================================
#  GPU PROFILE - NVIDIA
# ==========================================
# New users:
#   - Don't edit this file directly.
#   - In users/<name>.nix, choose ONE GPU profile to import.
#
# Advanced:
#   - Tune hardware.nvidia options or packages here if needed.

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  X11 / DRM driver selection
  # ─────────────────────────────────────────
  #
  # Even on Wayland, this influences which kernel DRM driver
  # is used under the hood.

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
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # New users:
    #   - Keep the proprietary driver (open = false) unless
    #     you know you want the open module.
    open = false;

    nvidiaSettings = true;

    # Advanced:
    #   - You can switch to beta or other packages if needed.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ─────────────────────────────────────────
  #  Kernel modules and parameters
  # ─────────────────────────────────────────
  #
  # New users:
  #   - These are the usual NVIDIA kernel modules + DRM modeset.
  #   - You shouldn't need to change this.

  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];

  # ─────────────────────────────────────────
  #  Tools
  # ─────────────────────────────────────────

  environment.systemPackages = with pkgs; [
    nvidia-smi
    nvidia-settings
  ];
}
