{ pkgs, ... }: {
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
      };
      dock = {
        autohide = true;
      };
      finder = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
      };
    };
  };

  services.nix-daemon.enable = true;

  system.stateVersion = 4;
}
