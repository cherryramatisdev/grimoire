{ pkgs, ... }: {
    programs.bash.enable = true;
    users.users.cherry.home = "/Users/cherry";
    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
    imports = [
        ./settings/system.nix
    ];
}
