{ pkgs, ... }: with pkgs; {
    environment.systemPackages = [
        nixfmt-rfc-style
    ];
}
