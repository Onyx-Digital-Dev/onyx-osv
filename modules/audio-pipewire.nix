# ==========================================
#  OSV MODULE — AUDIO (PIPEWIRE)
# ==========================================
#
# PipeWire-based audio configuration for Onyx OSV. Disables
# PulseAudio, enables PipeWire with ALSA and PulseAudio
# compatibility, and configures RTKit.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  PulseAudio / PipeWire
  # ─────────────────────────────────────────

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };

  # ─────────────────────────────────────────
  #  Realtime scheduling
  # ─────────────────────────────────────────

  security.rtkit.enable = true;
}
