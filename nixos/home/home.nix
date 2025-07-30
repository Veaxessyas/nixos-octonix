{ config, pkgs, ... }:

{
  # Set your username and home path
  home.username = "octonix";
  home.homeDirectory = "/home/octonix";

  # Install user-specific packages (GUIs, tools, wayland stuff)
home.packages = with pkgs; [
  # Browsers & Editors
  librewolf
  zed-editor
  obsidian

  # File Managers & Utilities
  xfce.thunar
  loupe
  evince
  gnome-disk-utility
  gnome-system-monitor
  gnome-clocks
  gnome-characters
  qalculate-gtk
  deluge
  lutris
  platformio
  discord

  # File Archivers & CLI tools
  popsicle
  exiftool
  zip
  unrar
  eza
  bat

  # Themes & Icons
  tokyonight-gtk-theme
  papirus-icon-theme
  bibata-cursors

  # System & Power management
  linuxPackages.cpupower
  brightnessctl
  pavucontrol
  networkmanagerapplet

  # Wayland & Hyprland ecosystem
  hyprland
  kitty
  waybar
  wofi
  dunst
  grim
  slurp
  swappy
  hyprcursor
  hyprlang
  hyprutils
  hyprpaper
  hyprlock

  # Audio & Bluetooth
  aquamarine
  blueman
  playerctl

  # Miscellaneous
  neofetch
];
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza";
      cat = "bat";
    };

    # Zsh plugins
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Source the p10k theme
    initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };

  # Apply GTK theme, icon theme, and cursor
  gtk = {
    enable = true;

    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };

  # Enable fontconfig so user fonts can be read
  fonts.fontconfig.enable = true;

  # Enable git for this user
  programs.git.enable = true;

  # Lock Home Manager config version
  home.stateVersion = "25.05";
}
