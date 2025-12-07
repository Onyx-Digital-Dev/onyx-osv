# ==========================================
#  OSV MODULE — SECURITY
# ==========================================
#
# Baseline security posture for Onyx OSV. Focuses on OpenSSH
# defaults and is intended to be augmented by host-specific
# configuration.
#

{ config, pkgs, lib, ... }:

{
  # ─────────────────────────────────────────
  #  OpenSSH defaults
  # ─────────────────────────────────────────
  #
  # Default:
  #   - SSH disabled.
  #   - When enabled by a host, apply safer defaults that do
  #     not interfere with typical workstation usage.
  #

  services.openssh = {
    enable = lib.mkDefault false;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      AllowTcpForwarding = true;
    };

    # Do not automatically open firewall ports; hosts decide.
    openFirewall = lib.mkDefault false;
  };
}
