{ pkgs, ... }: with pkgs; {
    environment.systemPackages = [
        nixpkgs-fmt
    ];
}
