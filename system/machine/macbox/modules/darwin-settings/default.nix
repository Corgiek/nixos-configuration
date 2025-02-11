{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.module.darwin-settings;
in
{
  options = {
    module.services.darwin-settings.enable = mkEnableOption "Enable darwin settings";
  };

  config = mkIf cfg.enable {
    # System settings
    system = {
      defaults = {
        ".GlobalPreferences" = {
          "com.apple.mouse.scaling" = -1.0;
        };

        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          ApplePressAndHoldEnabled = false;
          AppleShowAllExtensions = true;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          NSAutomaticWindowAnimationsEnabled = false;
          NSDocumentSaveNewDocumentsToCloud = false;
          NSNavPanelExpandedStateForSaveMode = true;
          NSNavPanelExpandedStateForSaveMode2 = true;
          PMPrintingExpandedStateForPrint = true;
          AppleEnableMouseSwipeNavigateWithScrolls = false;
          AppleEnableSwipeNavigateWithScrolls = false;
          AppleShowAllFiles = true;
          AppleFontSmoothing = 0;
          AppleShowScrollBars = "WhenScrolling";
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSWindowShouldDragOnGesture = true;
          InitialKeyRepeat = 10;
          KeyRepeat = 1;
          AppleKeyboardUIMode = 3;
          NSWindowResizeTime = 0.1;
          "com.apple.keyboard.fnState" = true;
        };

        LaunchServices = {
          LSQuarantine = false;
        };

        trackpad = {
          TrackpadRightClick = true;
          TrackpadThreeFingerDrag = true;
          Clicking = true;
        };

        finder = {
          AppleShowAllFiles = true;
          CreateDesktop = false;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "Nlsv";
          QuitMenuItem = true;
          ShowPathbar = true;
          ShowStatusBar = true;
          _FXShowPosixPathInTitle = true;
          _FXSortFoldersFirst = true;
        };

        dock = {
          autohide = true;
          expose-animation-duration = 0.15;
          show-recents = false;
          showhidden = true;
          tilesize = 30;
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
          mru-spaces = false;
          orientation = "left";
        };

        screencapture = {
          location = "/Users/${userConfig.name}/Downloads/temp";
          type = "png";
          disable-shadow = true;
        };
      };

      keyboard = {
        enableKeyMapping = true;
        # Remap §± to ~
        userKeyMapping = [
          {
            HIDKeyboardModifierMappingDst = 30064771125;
            HIDKeyboardModifierMappingSrc = 30064771172;
          }
        ];
      };
    };

    system.defaults.alf.allowdownloadsignedenabled = 1;

    system.defaults.CustomUserPreferences = {
      NSGlobalDomain = {
        TSMLanguageIndicatorEnabled = 0;
        QLPanelAnimationDuration = 0;
        NSAutomaticWindowAnimationsEnabled = 0;
      };

      "com.apple.finder" = {
        _FXSortFoldersFirst = true;
        CreateDesktop = true;
        ShowHardDrivesOnDesktop = false;
        ShowExternalHardDrivesOnDesktop = false;
        ShowRemovableMediaOnDesktop = true;
        ShowMountedServersOnDesktop = false;
      };

      "com.apple.BluetoothAudioAgent" = {
        # from https://github.com/joeyhoer/starter/blob/master/system/bluetooth.sh
        "Apple Bitpool Max (editable)" = 80;
        "Apple Bitpool Min (editable)" = 48;
        "Apple Initial Bitpool (editable)" = 40;
        "Negotiated Bitpool" = 48;
        "Negotiated Bitpool Max" = 53;
        "Negotiated Bitpool Min" = 48;
        "Stream - Flush Ring on Packet Drop (editable)" = 30;
        "Stream - Max Outstanding Packets (editable)" = 15;
        "Stream Resume Delay" = "0.75";
      };

      "com.apple.dock".size-immutable = true;
      "com.apple.frameworks.diskimages".skip-verify = true;
      "com.apple.CrashReporter".UseUNC = 1;
      com.apple.helpviewer.DevMode = true;
    };
  };
}
