{ config, pkgs, inputs, lib, ... }:
{
	home.username = "xozu";
  home.homeDirectory = "/home/xozu";
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ HYPRLAND SETUP ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;
		systemd.enable = true;

# ✨ SETTINGS ✨

		settings = {
			"$mod" = "SUPER";
			"$terminal" = "kitty";
			"$fileManager" = "thunar";
			"exec-once" = [ "waybar" "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" "nm-applet" "blueman-applet" ];

# ✨ VARIABLES ✨

		env = [
        "XCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "XCURSOR_SIZE,16"
        "HYPRCURSOR_THEME,catppuccin-mocha-mauve-cursors"
        "HYPRCURSOR_SIZE,16"
				"HYPRSHOT_DIR,$HOME/Pictures/Screenshots"
      ];

# ✨ MONITORS ✨

		monitor = [
			"eDP-1, 1920x1200@60, 0x0, 1"
			"HDMI-A-1, preffered, auto, 1"
			];

		workspace = [
			"1, monitor:eDP-1"
			"2, monitor:eDP-1"
			"3, monitor:eDP-1"
			"4, monitor:eDP-1"
			"5, monitor:eDP-1"
			"6, monitor:eDP-1"
			"7, monitor:eDP-1"
			"8, monitor:eDP-1"
			"9, monitor:HDMI-A-1"
			];        

# ✨ INPUTS ✨

		device = {
			name = "epic-mouse-v1";
			sensitivity = "-0.5";
			};

		gestures = {
			workspace_swipe = "on";
			workspace_swipe_cancel_ratio = 0;
			workspace_swipe_min_speed_to_force = 0;
			workspace_swipe_distance = 75;
			};

		input = {
			kb_layout = "us,sk";
			kb_variant = ",qwerty";
			kb_options = "caps:swapescape, grp:alt_shift_toggle";
			follow_mouse = "1";
			touchpad = {
				natural_scroll = "yes";
  			};
		};

# ✨ DESIGN ✨

		general = {
			resize_on_border = true;
			gaps_in = 5;
			gaps_out = 7;
			border_size = 2;
			layout = "dwindle";
			allow_tearing = false;
			};

		decoration = {
			rounding = 5;
		blur = {
			enabled = true;
			size = 10;
			passes = 4;
			};
		dim_inactive = false;
		dim_strength = "0.2";
		inactive_opacity = "0.80";
		# active_opacity = "0.95";
		shadow = {
			enabled = "yes";
			range = 5;
			render_power = "1";
			};    
		};

		animations = {
			enabled = "yes";
			bezier = [
				"windowmove, 0.2, 0.75, 0.55, 1"
				"windowclose, 1, 0, 0, 1"
				"windowin, 0.01, 1, 0.5, 1"
				"workspacemove, 1, 1, 1, 1"
				];
			animation = [
				"windowsMove, 1, 6, windowmove"
				"windowsIn, 1, 7, windowin"
				"windowsOut, 0, 1, windowclose"
				"workspaces, 1, 0.001, default, slidevert"
				];
		};

		windowrulev2 = "suppressevent maximize, class:.*";
		# windowrule = "opacity 0.92 0.85,thunar";
		dwindle = {
			pseudotile = "yes"; 
			preserve_split = "yes"; 
		};

		misc = {
			force_default_wallpaper = 0;
		};
		

# ✨ BINDS ✨

		bind = [
      "$mod SHIFT, F, togglefloating "
      "$mod, Q, killactive, "
      "$mod, F, fullscreen, "
      "$mod, H, togglesplit, "
      "$mod, O, exec, hyprctl setprop active opaque toggle "
      "$mod, P, pseudo, "
      "$mod, left, movefocus, l "
      "$mod, right, movefocus, r "
      "$mod, up, movefocus, u "
      "$mod, down, movefocus, d "
      "$mod, J, movefocus, l "
      "$mod, L, movefocus, r "
      "$mod, I, movefocus, u "
      "$mod, K, movefocus, d "
      "$mod SHIFT, left, movewindow, l "
      "$mod SHIFT, right, movewindow, r "
      "$mod SHIFT, up, movewindow, u "
      "$mod SHIFT, down, movewindow, d "
      "$mod SHIFT, H, movewindow, l "
      "$mod SHIFT, L, movewindow, r "
      "$mod SHIFT, I, movewindow, u "
      "$mod SHIFT, K, movewindow, d "
      "$mod, Tab, exec, $terminal "
      "$mod, E, exec, $fileManager "
      "$mod, M, exec, powermenu_t4 "
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
			", PRINT, exec, hyprshot -m region"
			"$mod, PRINT, exec, hyprshot -m output"
      ];

    bindr = [
      "$mod, $mod_L, exec, hyprlauncher"
	     ];

    binde = [
    	"$mod CTRL, up, exec, hyprctl dispatch resizeactive 0 -20"
			"$mod CTRL, down, exec, hyprctl dispatch resizeactive 0 20"
			"$mod CTRL, left, exec, hyprctl dispatch resizeactive -20 0" 
			"$mainMod CTRL, right, exec, hyprctl dispatch resizeactive 20 0" 
			", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"
			", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"
			", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			", xf86monbrightnessup, exec, brightnessctl set 10%+"
			", xf86monbrightnessdown, exec, brightnessctl set 10%-"
      ];

    bindm = [
    	"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizewindow"
			];
		 };
	 };
 
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ WAYBAR ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "left";
				margin = "3px";
				width = 40;
 
				modules-left = ["hyprland/workspaces"];
				modules-center = ["clock"];
				modules-right = [ "wireplumber" "battery" "hyprland/language" "backlight" "tray" "custom/powermenu"];
				
# ✨ MODULES ✨

				"hyprland/language" = {
					"format" = "{}";
					"format-en" = "";
					"format-sk" = "";
					};

				"hyprland/workspaces" = {
					"format" = "<sub>{icon}</sub>\n{windows}";
					"format-window-separator" = "\n";
					"window-rewrite-default" = "";
					"window-rewrite" = {
						"Freetube" = "󰗃";
						"firefox" = "󰈹";
						"title<vim>" = "";
				  	"title<nvim>" = "";
						"title<helix>" = "󰚄";
				  	"class<kitty>" = "󰄛";
						"timeshift" = "󱫐";
						"gimp" = "";
						"mpv" = "";
						"mirage" = "";
						"evince" = "󰈙";
						"libre" = "";
						"thunar" = "󰪶";
						"pavucontrol" = "󰗅";
						"zen" = "";
						};
					};

				"clock" = {
	        "format" = "{:%H\n%M}";
	        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					"calendar" = {
						"format" = {
							"today" = "<span color='#7C69D2'><u>{}</u></span>";
							};
						};
			    };

				"wireplumber" = {
					"format-muted" = "";
					"format" = "{icon}";
					"states" = {
						"veryhigh" = 101;
						"max" = 150;
						};
					"on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
					"on-click-right" = "pavucontrol";
					"max-volume" = 150;
					"format-icons" = ["󰕿" "󰖀" "󱄠" "󰕾"];
					"reverse-scrolling" = true;
					"scroll-step" = 1;
					"rotate" = 90;
					"tooltip-format" = "{volume}%";
					};

				"battery" = {
					"states" = {
						"full" = 100;
						"normal" = 90;
						"warning" = 25;
						"critical" = 15;
						};
					"format" = "{icon}";
					"interval" = 5;
	        "format-icons" = { 
						"default" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
						"charging" = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
						};
					"tooltip-format" = "{capacity}%";
			    };

				"backlight" = {
					"device" = "intel_backlight";
					"format" = "{icon}";
					"states" = {
						"full" = 100;
						};
					"format-icons" = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
					"on-scroll-down" = "brightnessctl s 5%-";
					"on-scroll-up" = "brightnessctl s +5%";
					"tooltip" = true;
					"tooltip-format" = "{percent}% ";
					"smooth-scrolling-threshold" = 1;
				  };

				"memory" = {
					"interval" = 60;
					"format" = "";
					"tooltip-format" = "{percentage}% RAM\n{swapPercentage}% SWAP";
				};

				"custom/powermenu" = {
					"format" = "󰐥";
					"tooltip" = false;
					"on-click" = "powermenu_t4";
					};
				};
			};
		};

# ✨ STYLE ✨

programs.waybar.style = 
	''
	*{
	font-family: "JetBrainsMono Nerd Font,JetBrainsMono NF";
	font-size: 22px;
	font-weight: bold;
	}
	
	window#waybar {
		background: rgba(0,0,0,0);
		}

	#workspaces {
		padding: 10px 5px 20px 0px;
  	border-bottom: 3px solid;
  	border-bottom-left-radius: 5px;
  	border-bottom-right-radius: 50px;
  	border-top: 3px solid;
  	border-top-left-radius: 50px;
  	border-top-right-radius: 5px;
		}

	#workspaces button {
		padding: 0 5px;
  	background-color: transparent;
		}

	#workspaces button.active {
		color: #7C69D2;
		}

	#clock {
		padding: 20px 5px 20px 5px;
  	border-bottom: 3px solid;
  	border-bottom-left-radius: 5px;
  	border-bottom-right-radius: 50px;
  	border-top: 3px solid;
  	border-top-left-radius: 50px;
  	border-top-right-radius: 5px;
		}

	#wireplumber {
		border-top: 3px solid @border;
  	border-top-left-radius: 50px;
  	border-top-right-radius: 5px;
		padding-top: 25px;
		padding-bottom: 10px;
		}

	#wireplumber.veryhigh {
		color: red;
		}

	#battery {
		padding-left: 1px;
		}

	#battery.warning:not(.charging) {
		color: #c98908;
		}

	#battery.critical:not(.charging) {
		color: #ff0000;
		}

	#backlight {
		padding-top: 10px;
		padding-right: 3px;
		}

	#memory {
		padding-right: 10px;
	}

	#backlight.full {
		color: yellow;
		}

	#tray {
		padding-bottom: 10px;
		padding-top: 10px;
		padding-left: 5px;
		}

	#custom-powermenu {
		color: #fa0018;
		padding-bottom: 15px;
		padding-left: 3px;
		border-bottom: 3px solid;
		border-color: white;
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 50px;
		}

	tooltip {
	  border: solid;
	  border-width: 1.5px;
	  border-radius: 8px;
	  border-color: #cdd6f4;
		}
		tooltip label {
		  color: #cdd6f4;
		  font-weight: normal;
		  margin: 0.25px;
		}

	#pulseaudio-slider,#wireplumber,#battery,
	#backlight,#tray,#custom-updates,
	#custom-powermenu,#clock,#workspaces,#language,#memory {
		background: #0e0c1a;
		}
	'';

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ ROFI ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.rofi = {
		enable = true;
		terminal = "kitty";
		};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ TEXTFOX ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  imports = [ inputs.textfox.homeManagerModules.default ];

  textfox = {
    enable = true;
    profile = "xozu"; 
	  };
  
# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ ZSH ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			ls = "ls --color=tty";
			c = "clear";
			fetch = "fastfetch";
			garbage = "sudo nix-collect-garbage -d";
			update="cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake /etc/nixos#default && flatpak update";
			rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#default";
			oldgen = "sudo nix-collect-garbage --delete-older-than 3d";
			listgen = "nix-env --list-generations";
			etc = "cd /etc/nixos";
			config = "cd /etc/nixos && sudoedit configuration.nix";
			home = "cd /etc/nixos && sudoedit home.nix";
			flake = "cd /etc/nixos && sudoedit flake.nix";
			hardware = "cd /etc/nixos && sudoedit hardware-configuration.nix";
			};
		};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ KITTY ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.kitty = {
		enable = true;
		themeFile = "tokyo_night_moon";
		shellIntegration.enableZshIntegration = true;
		settings = {
			confirm_os_window_close = 0;
			line_height = 1;
			use_font_shaping = true;
			selecion_background = "#6a6094";
			background_opacity = lib.mkForce 0.8;
			};
		};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ STARSHIP ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
		settings = {
			format = "[](#a3aed2)[](bg:#a3aed2 fg:#090c0c)[](bg:#9f76f0 fg:#a3aed2)$directory[](fg:#9f76f0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[](fg:#1d2230)$character";
			directory = {
			style = "fg:#e3e5e5 bg:#9f76f0";
			format = "[ $path ]($style)";
			truncation_length = 3;
			truncation_symbol = "…/";
			};

		directory.substitutions = {
			"Documents" = "󰈙 ";
			"Downloads" = " ";
			"Music" = " ";
			"Pictures" = " ";
			};

		git_branch = {
			symbol = "";
			style = "bg:#394260";
			format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
			};

		git_status = {
			style = "bg:#394260";
			format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
			};

		nodejs = {
			symbol = "";
			style = "bg:#212736";
			format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

		#the cute crab seems to be default symbol, make sure you have an emoji font installed like ttf-joypixels
		rust = {
			style = "bg:#212736";
			format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

		golang = {
			symbol = "";
			style = "bg:#212736";
			format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

		php = {
			symbol = "";
			style = "bg:#212736";
			format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
			};

		time = {
			disabled = false;
			time_format = "%R";
			style = "bg:#1d2230";
			format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
			};
		};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ HELIX ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛ 

	stylix.targets = {
		helix.enable = false;
		waybar.enable = false;
		};

		programs.helix = {
		enable = true;
		defaultEditor = true;
		settings = {
			theme = "horizon-dark-custom";
			editor = {
				line-number = "relative";
				color-modes = true;
				true-color = true;
				bufferline = "multiple";
				cursor-shape = {
					insert = "bar";
					normal = "block";
					select = "underline";
					};
				file-picker = {
					hidden = false;
					};
				statusline = {
					left = [ "mode" "read-only-indicator" "file-modification-indicator" ];
					center = [ "file-name" ];
					right = [ "diagnostics" "position" ];
					separator = "│";
					mode = {
						normal = "NORMAL";
						insert = "O-RIDE";
						select = "SELECT";
						};
					};
				};
			keys = {
				normal = {
					j = "move_char_left";
					k = "move_visual_line_down";
					i = "move_visual_line_up";
					I = "half_page_up";
					K = "half_page_down";
					o = "insert_mode";
					O = "insert_at_line_start";
					"ret" = [ "open_below" "normal_mode" ];
					"S-ret" = [ "open_above" "normal_mode" ];
					};
				select = {
					j = "move_char_left";
					k = "move_visual_line_down";
					I = "half_page_up";
					K = "half_page_down";
					i = "move_visual_line_up";
					o = "insert_mode";
					};
				};
			};
			themes = {
				"horizon-dark-custom" = {
					inherits = "horizon-dark";
					"ui.background" = "#14131D";
					
				};
			};
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ PACKAGES ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ 

  home.packages = with pkgs; [

  (pkgs.stdenvNoCC.mkDerivation rec {
    name = "rofi-launchers";

    src = pkgs.fetchFromGitHub {
      owner = "X07U";
      repo = "nixos-rofi";
      rev = "master";
      hash = "sha256-MSNQDjU7lIcPqNQs1Y1oJOISbHQkxU5pXpfM+Wm7r9Q=";
    };

    buildInputs = [ pkgs.rofi ];

    postPatch = ''
      files=$(find files/scripts -type l)
      for file in $files; do
        substituteInPlace $file \
          --replace-fail '$HOME/.config/rofi' "$out/share" \
          --replace-fail "rofi " "${pkgs.lib.getExe pkgs.rofi} "
      done

      files=$(find files -type f -name "*.rasi")
      for file in $files; do
        substituteInPlace $file \
          --replace-quiet '~/.config/rofi' "$out/share"
      done
    '';

    installPhase = ''
      runHook preInstall

      # Install all scripts as binaries
      mkdir -p $out/bin
      for script in files/scripts/*; do
        install -Dm755 $script $out/bin/$(basename $script)
      done

      # Install Fonts
      mkdir -p "$out/share/fonts"
      cp -r fonts/* "$out/share/fonts"

      # Install other necessary files
      mkdir -p "$out/share"
      cp -r files/* "$out/share"

      runHook postInstall
    '';

    meta = {
      description = "A collection of rofi launchers";
      homepage = "https://github.com/X07U/nixos-rofi";
      maintainers = [];     
    };
  })
  ];

	programs.zathura.enable = true;
	

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ HOME MANAGER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

     };

  home.sessionVariables = {
		BROWSER = "firefox";
		TERMINAL = "kitty";
	  };

  programs.home-manager.enable = true;
  
# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ GTK ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛  

  gtk = {
    enable = true;
    cursorTheme.name = "catppuccin-mocha-mauve-cursors";
    cursorTheme.size = 16;
		iconTheme.package = pkgs.catppuccin-papirus-folders.override {
	    flavor = "mocha";
	    accent = "lavender";
		  };
		iconTheme.name = "Papirus-Dark";
	  };

	qt = {
	  enable = true;
	  platformTheme.name = "gtk";
		};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ DUNST ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛   

  services.dunst = {
		enable = true;
  	settings = {
		  global = {
	    allow_markup = "yes";
	    markup = "yes";
	    format = "<span foreground='#8d5bb4'><b>%s</b></span>\n%b";
	    sort = "yes";
	    indicate_hidden = "yes";
	    bounce_freq = 0;
	    show_age_threshold = 60;
	    word_wrap = "yes";
	    ignore_newline = false;
	    origin = "top-center";
	    transparency = 0;
	    idle_threshold = 120;
	    monitor = 0;
	    follow = "mouse";
	    sticky_history = "yes";
	    line_height = 0;
	    separator_height = 2;
	    padding = 12;
	    horizontal_padding = 12;
	    separator_width = 1;
	    startup_notification = false;
	    corner_radius = 15;
	    frame_width = 1;
	    width = 400;
	    progress_bar_max_width = 400;
	    progress_bar_min_width = 400;
	    progress_bar_height = 10;
	    progress_bar_frame_width = 1;
	    progress_bar_corner_radius = 5;
	    scale = 1;
	    min_icon_size = 64;
	    max_icon_size = 64;
	    alignment = "center";
	    vertical_alignment = "center";
		  };
    urgency_low = {
	    timeout = 5;
	    };
    urgency_normal = {
	    timeout = 20;
	    };
    urgency_critical = {
	    timeout = 0;
	    };
	  };
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ MPV ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛

	programs = {
		mpv.enable = true;
		};

# ┏━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ EZA ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━┛

	programs.eza = {
		enable = true;
		icons = "always";
		extraOptions = [ "-T" ];
 		};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ WLOGOUT ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.wlogout = {
		enable = true;
		layout = [
			{
		    label = "lock";
		    action = "hyprlock";
		    keybind = "x";
			}
			{
		    label = "reboot";
		    action = "systemctl reboot";
		    keybind = "r";
			}
			{
		    label = "logout";
		    action = "hyprctl dispatch exit";
		    keybind = "l";
			}
			{
		    label = "shutdown";
		    action = "systemctl poweroff";
		    keybind = "s";
			}
			];
		style = ''
		* {
    background-image: none;
    transition: 20ms;
    box-shadow: none;
		}

		window {
	    background-image: url("/home/xozu/Pictures/wallpaper.png");
			}

		button {
	    color: #FFFFFF;
	    background-position: center;
	    background-repeat: no-repeat;
	    background-size: 20%;
	    border: none;
		  border-radius: 10px;
		  outline-style: none;
			}

		/* options */ 
		#lock {
	    background-color: #7C69D2;
			background-image: url("/home/xozu/Downloads/lock.png");
	    border-radius: 5px 0px 0px 0px;
	    margin : 50px 0px 0px 110px;
			}

		#reboot {
	    background-color: #9887E0;
			background-image: url("/home/xozu/Downloads/lock.png");
		  border-radius: 0px 0px 0px 5px;
	    margin : 0px 0px 250px 550px;
			}

		#logout {
	    background-color: #B5A6ED;
			background-image: url("/home/xozu/Downloads/lock.png");
		  border-radius: 0px 5px 0px 0px;
	    margin : 250px 550px 0px 0px;
			}

		#shutdown {
	    background-color: #D3CFF9;
			background-image: url("/home/xozu/Downloads/lock.png");
		  border-radius: 0px 0px 5px 0px;
	    margin : 0px 550px 250px 0px;
			}

		/* options on hover */ 
		button:hover {
	    background-size: 25%;
			}

		button:hover#lock {
	    border-radius: 10px 10px 0px 10px;
	    margin : 80px 0px 0px 530px;
			}

		button:hover#reboot {
	    border-radius: 10px 0px 10px 10px;
	    margin : 0px 0px 80px 530px;
			}

		button:hover#logout {
	    border-radius: 10px 10px 10px 0px;
	    margin : 80px 530px 0px 0px;
			}

		button:hover#shutdown {
	    border-radius: 0px 10px 10px 10px;
	    margin: 0px 530px 80px 0px;
			}
		'';
	};

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ NCMPCPP ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.ncmpcpp.enable = true;

# ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
# ✨			✨ OTHER ✨			✨
# ┗━━━━━━━━━━━━━━━━━━━━━━━━┛

	programs.btop.enable = true;

	programs.yazi.enable = true;
	programs.zoxide.enable = true;

	#This is very handy. In this case it rewrites use_gtk_colors to true in Hyprlaunchers config file
	home.activation.modifyHyprlauncherConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  if [ -f ~/.config/hyprlauncher/config.json ]; then
    jq '.window.use_gtk_colors = true' ~/.config/hyprlauncher/config.json > ~/.config/hyprlauncher/config.json.tmp
    mv ~/.config/hyprlauncher/config.json.tmp ~/.config/hyprlauncher/config.json
  fi
'';


}
