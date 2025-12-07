# ==========================================
#  OSV MODULE — VIRTUALISATION
# ==========================================
#
# Virtualisation stack for Onyx OSV. Provides libvirt/KVM,
# tooling for managing VMs, and related utilities.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Libvirt / KVM
  # ─────────────────────────────────────────
  #
  # Provides QEMU/KVM via libvirtd. User group membership
  # is handled separately in host/user configuration.
  #

  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        # Use QEMU/KVM backend; default package is sufficient for most cases.
        # package = pkgs.qemu_kvm;  # optional override if needed
        swtpm.enable = true;
      };

      onBoot = "start";
      onShutdown = "shutdown";
    };

    spiceUSBRedirection.enable = true;
  };

  # ─────────────────────────────────────────
  #  IOMMU kernel parameters
  # ─────────────────────────────────────────
  #
  # Enable IOMMU and passthrough-friendly behavior by default
  # on systems that use the OSV virtualisation stack.
  #

  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];


  # ─────────────────────────────────────────
  #  Management tools
  # ─────────────────────────────────────────

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    # Management
    virt-manager
    virt-viewer
    spice-gtk

    # High-performance client (Looking Glass)
    looking-glass-client

    # QEMU / firmware / guest tools
    qemu
    OVMF
    libguestfs
    guestfs-tools
  ];
}
