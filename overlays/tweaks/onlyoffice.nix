_: final: prev: {
  onlyoffice-desktopeditors = prev.onlyoffice-desktopeditors.override {
    buildFHSEnv =
      args:
      final.buildFHSEnv (
        args
        // {
          extraBwrapArgs = (args.extraBwrapArgs or [ ]) ++ [
            ''--ro-bind-try "$HOME/.nix-profile/share/fonts" "$HOME/.local/share/fonts/onlyoffice"''
          ];
        }
      );
  };
}
