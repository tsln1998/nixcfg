{ lib, ... }:
{
  options.programs.plasma.launchers = {
    icontasks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Ordered launcher URLs for the Plasma Icons-only Task Manager.";
    };

    kickoff = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Ordered desktop entry IDs used to seed Kickoff favorites.";
    };
  };
}
