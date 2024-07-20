_: prev: {
  waybar = prev.waybar.override {
    pulseSupport = false;
    sndioSupport = false;
    mpdSupport = false;
    mprisSupport = false;
  };
}
