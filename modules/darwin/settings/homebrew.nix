{ pkgs, ... }: {
  homebrew = {
    brewPrefix = "/opt/homebrew/bin";
    enable = true;
    caskArgs.no_quarantine = true;
    casks = [
      "raycast"
      "font-comic-shanns-mono-nerd-font"
      "font-symbols-only-nerd-font"
    ];
    taps = [
      "homebrew/cask-fonts"
    ];
  };
}
