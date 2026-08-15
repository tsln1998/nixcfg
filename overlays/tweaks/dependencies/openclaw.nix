_: final: prev: {
  repos = prev.repos // {
    agents = prev.repos.agents // {
      openclaw = prev.repos.agents.openclaw.override {
        nodejs = final.repos.unstable.nodejs;
      };
    };
  };
}
