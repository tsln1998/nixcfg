{ lib, ... }: {
  launchd.agents.activate-agenix = {
    config = {
      KeepAlive = {
        Crashed = lib.mkForce true;
      };
    };
  };
}
