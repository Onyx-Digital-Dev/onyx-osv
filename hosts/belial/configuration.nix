{ config, pkgs, lib, ... }:

{
  imports = [
    # Generated hardware description (copied from /etc/nixos)
    ./hardware-configuration.nix

    # Your original Belial config, untouched
    ./configuration-legacy.nix

    # ---- OSV core + profile (we'll hook these up later) ----
     ../../base/core.nix
     ../../base/nix.nix
     ../../profiles/workstation.nix

     ../../modules/fonts.nix
     ../../modules/mpd.nix
     ../../modules/virtualisation.nix
     ../../modules/ollama.nix
     ../../modules/audio-pipewire.nix
          
    # ---- GPU selection (for ISO users to uncomment ONE) ----
    # ../../modules/gpu/amd.nix
    # ../../modules/gpu/intel.nix
     ../../modules/gpu/nvidia.nix
    # ../../modules/gpu/nvidia-prime.nix
  ];
}
