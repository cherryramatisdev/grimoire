{ pkgs, ... }: {
  homebrew = {
    brewPrefix = "/opt/homebrew/bin";
    enable = true;
    caskArgs.no_quarantine = true;
    brews = [
        "elixir"
        "erlang"
        #"orbstack"
    ];
    casks = [
      "google-chrome"
      "raycast"
      "postman"
      "font-comic-shanns-mono-nerd-font"
      "font-symbols-only-nerd-font"
      #"visual-studio-code"
    ];
    taps = [
      "homebrew/cask-fonts"
    ];
  };
}
