{ config, pkgs, lib, inputs, ... }: {
# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ CORE ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 
  imports = [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
# these 3 are the easiest way to setup qt themes globally, the config options are horrible. 
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
# not sure about qt6, but some packages claim they support both qt5 and qt6, it's such a mess
    # QT_QPA_PLATFORMTHEME_qt6 = "qt6ct";
  };
  
  system.stateVersion = "24.05"; 
  powerManagement.enable = true;
  services.thermald.enable = true;
  nix.optimise.automatic = true;

  services.thinkfan.enable = true;

# ✨ SYSTEMD ✨

  systemd = {
    services."garbage".script = ''
      for profile in /nix/var/nix/profiles/system $HOME/.local/state/nix/profiles/profile $HOME/.local/state/nix/profiles/home-manager; do
        sudo nix-env --delete-generations +5 -p $profile;
      done
    '';
    timers."garbage" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
      };
    };
  };

# ✨ GRUB ✨

  boot.loader = {
    efi.efiSysMountPoint = "/boot/efi";
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    timeout = 1;
    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ PROGRAMS ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  programs = {
    hyprland.enable = true;
    firefox.enable = true;
    zsh.enable = true;
    file-roller.enable = true;
    xfconf.enable = true;
  };

nixpkgs.overlays = [
    (final: prev: {
      catppuccin-kvantum = prev.catppuccin-kvantum.override {
        accent = "lavender";
        variant = "mocha";
      };
    })
  ];

  environment.systemPackages = with pkgs; [
    gimp
    hyprpicker
    hyprpolkitagent
    wl-clipboard
    brightnessctl
    hyprshot
    nil
    vscode-langservers-extracted
    greetd.tuigreet
    pavucontrol
    mpd
    qalculate-qt
    featherpad
    lightly-qt
    libsForQt5.qt5.qtwayland
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    (catppuccin-kvantum.override {
      accent = "mauve";
      variant = "mocha";
    })
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
  ];

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ NETWORK ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  networking = {
    hostName = "nixos"; 
    networkmanager.enable = true;
  };
  programs.nm-applet.enable = true;

# ✨ BLUETOOTH ✨

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ LOCALES ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  time.timeZone = "Europe/Bratislava";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sk_SK.UTF-8";
    LC_IDENTIFICATION = "sk_SK.UTF-8";
    LC_MEASUREMENT = "sk_SK.UTF-8";
    LC_MONETARY = "sk_SK.UTF-8";
    LC_NAME = "sk_SK.UTF-8";
    LC_NUMERIC = "sk_SK.UTF-8";
    LC_PAPER = "sk_SK.UTF-8";
    LC_TELEPHONE = "sk_SK.UTF-8";
    LC_TIME = "sk_SK.UTF-8";
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ SERVICES ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  services = {
    flatpak.enable = true;
    gvfs.enable = true;
    tlp.enable = true;
    printing.enable = true;
  };

# ✨ GREETD ✨

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --asterisks-char '•' --greeting 'System Operational ... Authentication in Progress' --user-menu --remember --theme 'border=magenta;text=cyan;prompt=gree;time=magenta;action=magenta;container=black;input=magenta' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ SOUND ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ USER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  users.users.xozu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  environment.pathsToLink = [ "/share/zsh" ];

 # ✨ HOME MANAGER ✨ 

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xozu" = import ./home.nix;
    };
  };

 # ✨ QT ✨ 

# QT is a bitch. The only way I made it work, is via Home Manager and config variables (see at the top). The wiki leads to a shitfest forum post.

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ STYLIX ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛   
   
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://i.postimg.cc/SKJtdrYT/wallpaper.png";
      sha256 = "sha256-E6W5wRTkX+g737+l3BqOkb68phtKCcl3HBeIZ8ij6tg=";
    };
    base16Scheme = {
      base00 = "14131d";
      base01 = "343051";
      base02 = "3b3854";
      base03 = "343051";
      base04 = "7b7bbb";
      base05 = "b8b8ff";
      base06 = "b8b8ff";
      base07 = "0b091d";
      base08 = "ff8888";
      base09 = "ffa588";
      base0A = "fffdd0";
      base0B = "88ff88";
      base0C = "88ffff";
      base0D = "beddff";
      base0E = "e7c5ff";
      base0F = "b8b8ff";
    };
    autoEnable = true;
    cursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 16;
    };
    targets = {
      grub.enable = false;
    };
  };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ THUNAR ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  #to open files with Helix (or any other terminal app) do "open with -> set default application -> command 'kitty -e hx %F'"
  #to fix openTerminal, do edit -> configure custom actions -> settings -> command 'kitty'
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
  };

services.mpd = {
		enable = true;
    user = "xozu";
    musicDirectory = "/home/xozu/Music";
    extraConfig = ''
  audio_output {
    type "alsa"
    name "My ALSA"
    device			"hw:0,0"	# optional 
    format			"44100:16:2"	# optional
    mixer_type		"hardware"
    mixer_device	"default"
    mixer_control	"PCM"
  }
'';
	};
#   systemd.services.mpd.environment = {
#     # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
#     XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.xozu.uid}"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
# };

}
