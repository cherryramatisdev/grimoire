{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "Fira Code";
      font.size = 15;
    };
  };
}
