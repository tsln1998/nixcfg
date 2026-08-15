{ pkgs, ... }: {
  programs.nix-ld.libraries = [
    # For self-contained .NET Core applications
    pkgs.icu
  ];
}
