{ pkgs, ... }: {
  programs.pi = {
    extraPackages = [
      # for pi-rtk-optimizer
      pkgs.rtk
      # for plannotator/pi-extension
      pkgs.python3
    ];

    settings = {
      packages = [
        # 命令输出过滤，节省 Token 用量并提升速度
        "npm:pi-rtk-optimizer@0.9.0"
        # 只读探索代码库，并在执行前先制定计划
        "npm:@plannotator/pi-extension@0.28.31"
        # 自动重试错误
        "npm:@monotykamary/pi-retry@0.11.3"
        # 启用“少写代码”的资深开发模式
        "npm:@dietrichgebert/ponytail@5.3.2"
        # 需要澄清时向用户发起结构化问卷
        "npm:@juicesharp/rpiv-ask-user-question@2.15.0"
      ];

      piRetry = {
        baseDelayMs = 1000;
        maxDelayMs = 6000;
        multiplier = 2;
        maxRetriesAtMaxDelay = 100;
      };
    };
  };
}
