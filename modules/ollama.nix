# ==========================================
#  OSV MODULE — OLLAMA
# ==========================================
#
# Ollama service configuration for Onyx OSV. Provides a local
# model server with CUDA acceleration and a default model set.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  Ollama service
  # ─────────────────────────────────────────

  services.ollama = {
    enable = true;
    acceleration = "cuda";

    # Default models to preload. Hosts can override or extend
    # this list as needed.
    loadModels = [
      "codellama:13b"
      "codegemma:7b"
    ];
  };
}
