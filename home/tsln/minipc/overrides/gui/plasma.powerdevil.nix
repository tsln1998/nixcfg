_: {
  programs.plasma.powerdevil = {
    # 交流供电
    AC = {
      powerButtonAction = "nothing";

      autoSuspend = {
        action = "nothing";
      };

      turnOffDisplay = {
        idleTimeout = 10 * 60;
        idleTimeoutWhenLocked = 5 * 60;
      };

      dimDisplay = {
        enable = false;
      };
    };
  };
}
