{ inputs, config, ... }:
let
  inherit (inputs) homebrew-core homebrew-cask;
in
{
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = config.homebrew.enable;

    # Apple Rosetta 2
    enableRosetta = false;

    # User owning the Homebrew prefix
    user = config.system.primaryUser;

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;

    # Optional: Declarative Homebrew tap trust entries.
    #
    # Note: The trust entries are _not_ removed if you remove them from those lists!
    # Use the `brew untrust` command to remove a trust entry.
    trust = {
      formulae = [ ];
      casks = [ ];
      commands = [ ];
      taps = [ ];
    };
  };

  homebrew = {
    onActivation = {
      cleanup = "zap";
    };
  };
}
