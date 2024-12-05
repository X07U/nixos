{ config, pkgs, lib, inputs, ... }:
  let
    GreetdHyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
      exec-once = regreet; hyprctl dispatch exit
    '';
  in
{
# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ CORE ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "24.05"; 

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
    thunar.enable = true; #to open files with Helix (or any other terminal app) do "open with -> set default application -> command 'kitty -e hx %F'"
    #to fix openTerminal, do edit -> configure custom actions -> settings -> command 'kitty'
    };

  programs.xfconf.enable = true;

  environment.systemPackages = with pkgs; [
    unzip
    git
    gimp
    hyprpicker
    wl-clipboard
    brightnessctl
    hyprshot
    nil
    vscode-langservers-extracted
    greetd.tuigreet
    pavucontrol
    glib #only got this for gsettings
    hyprlauncher
    ];

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.jetbrains-mono
    ];

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ NETWORK ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  networking.hostName = "nixos"; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
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
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.tlp.enable = true;

  # services.xserver.displayManager.gdm.enable = true;


  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "Hyprland";
  #       user = "xozu";
  #     };
  #   };
  # };

  services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --asterisks-char '•' --greeting 'System Operational ... Authentication in Progress' --user-menu --remember --theme 'border=magenta;text=cyan;prompt=gree;time=magenta;action=magenta;container=black;input=magenta' --cmd Hyprland";
          user = "greeter";
        };
      };
    };

  # systemd.services.greetd.serviceConfig = {
  #   Type = "idle";
  #   StandardInput = "tty";
  #   StandardOutput = "tty";
  #   StandardError = "journal";
  #   TTYReset = true;
  #   TTYVHangup = true;
  #   TTYVTDisallocate = true;
  # };
    
  # programs.regreet = {
  #   enable = true;
  #   # theme.name = lib.mkForce "Adwaita-dark";
  #   };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
    };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ SOUND ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    };

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ USER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  users.users.xozu = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [

      ];
    };
    environment.pathsToLink = [ "/share/zsh" ];

 # ✨ HOME MANAGER ✨ 

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xozu" = import ./home.nix;
      };
    };

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
}
