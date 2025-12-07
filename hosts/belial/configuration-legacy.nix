# Enhanced NixOS configuration for belial with optimal VM support
# Copy this to /etc/nixos/configuration.nix and run: sudo nixos-rebuild switch

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # --- Basic system info ------------------------------------------------------
  networking.hostName = "belial";
  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  # --- Bootloader -------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Networking -------------------------------------------------------------
  networking.networkmanager.enable = true;

  # --- Display stack: SDDM + Plasma + Niri -----------------------------------
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;
  programs.niri.enable = true;

  # --- Printing ---------------------------------------------------------------
  services.printing.enable = true;

  # --- Input ------------------------------------------------------------------
  services.libinput.enable = true;

  # --- Audio (PipeWire) -------------------------------------------------------
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- User -------------------------------------------------------------------
  users.users.oskodiak = {
    isNormalUser = true;
    description = "oskodiak";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
      "kvm"
      "docker"
    ];
  };

  # --- NVIDIA / graphics ------------------------------------------------------
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "intel_iommu=on"
    "iommu=pt"
  ];

  programs.xwayland.enable = true;


  # --- Applications / programs ------------------------------------------------
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.virt-manager.enable = true;


  # --- System packages --------------------------------------------------------
  environment.systemPackages = with pkgs; [
    # CLI / workflow
    wget
    curl
    yazi
    fastfetch
    lsd
    bat
    fzf
    ripgrep
    fd
    tmux
    btop
    htop
    git
    git-crypt
    gcc
    gnumake
    pkg-config
    nodejs_22
    cmake
    cargo
    rustc
    unzip
    zip
    dbus

    # Terminals / editors
    kitty
    alacritty
    helix
    neovim

    # Desktop apps
    spotify
    discord
    obs-studio
    gimp
    krita
    claude-code
    pcmanfm-qt
    pavucontrol

    # Niri + Wayland helpers
    niri
    waybar
    grim
    slurp
    swaylock-effects
    brightnessctl
    mako
    gnome-keyring
    xdg-desktop-portal-gtk
    fuzzel
    xwayland-satellite
    wl-clipboard
    pamixer
    swaybg

    # Quickshell Tooling for OSV
    quickshell
    
    # VM tooling
    virt-manager
    virt-viewer
    spice-gtk
    looking-glass-client
    qemu
    OVMF
    libguestfs
    guestfs-tools

    # Network / security
    iperf3
    nmap
    wireshark
    tor
    wireguard-tools
    openssl

    # eBPF / low-level
    bpftools
    libbpf
    llvmPackages.clang
    llvmPackages.llvm

    # Dev libs
    ncurses
    fftw
    wayland
    wayland-protocols
    libxkbcommon
    mesa
    vulkan-loader
    wayland-scanner
    gtk3
    glib

    # Monitoring
    iotop
    nethogs
    lsof
    jq
    bc
    dunst
    
    # Toys
    ani-cli
    
    # Crypto toys
    monero-gui
    xmrig

  ];

  # --- SSH / firewall ---------------------------------------------------------
  services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 5900 5901 5902 5903 ];
  };

  # --- NixOS version ----------------------------------------------------------
  system.stateVersion = "25.05";
}
