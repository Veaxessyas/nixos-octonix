{ config, pkgs, ... }:

{
  # Include your hardware settings
  imports = [ ./hardware-configuration.nix ];

  # Bootloader setup (systemd-boot with EFI support)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the latest available Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "nixos";  # Your computer's name
  networking.networkmanager.enable = true;

  # Set your timezone
  time.timeZone = "Africa/Casablanca";

  # Set locale and language
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";
  };

  # Enable Hyprland (Wayland compositor)
  programs.hyprland.enable = true;
  services.displayManager.ly.enable = true;

  # Enable udisks2
  services.udisks2.enable = true;
  
  # Support MTP devices
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # Keyboard layout for X11 and console
  services.xserver.xkb.layout = "it";
  console.keyMap = "it2";

  # Enable printing support
  services.printing.enable = true;

  # Pipewire for sound (and disable Pulseaudio)
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth setup
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Create main user
  users.users.octonix = {
    isNormalUser = true;
    description = "octonix";
    extraGroups = [ "networkmanager" "wheel" "input" "dialout" ];
    shell = pkgs.zsh;
  };

  # Enable ZSH
  programs.zsh.enable = true;

  # Allow non-free packages (e.g. Discord, Chrome)
  nixpkgs.config.allowUnfree = true;

  # Enable flakes permanently in NixOS
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Install fonts (JetBrains Mono Nerd Font)
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  # Enable D-Bus (needed for many apps)
  services.dbus.enable = true;

  # Install essential system packages
  environment.systemPackages = with pkgs; [
    ly
    home-manager
    git wget unzip
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["octonix"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  services.flatpak.enable = true;

  # Enable power profiles
  services.power-profiles-daemon.enable = true;

  # This locks the version of NixOS configs, keep it pinned
  system.stateVersion = "25.05";
}
