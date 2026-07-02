{ config, ... }: {
  config = {
    system = {
      defaults = {
        finder = {
          FXPreferredViewStyle = "clmv";
        };

        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          AppleInterfaceStyleSwitchesAutomatically = false;

          "com.apple.keyboard.fnState" = true;
          "com.apple.swipescrolldirection" = true;

          KeyRepeat = 2;
          InitialKeyRepeat = 15;
        };
      };
    };
  };
}
