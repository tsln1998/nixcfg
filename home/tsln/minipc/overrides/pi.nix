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
        pkgs.pi-extensions.rtk-optimizer.spec
        # 只读探索代码库，并在执行前先制定计划
        pkgs.pi-extensions.plannotator.spec
        # 自动重试错误
        pkgs.pi-extensions.retry.spec
        # 启用“少写代码”的资深开发模式
        pkgs.pi-extensions.ponytail.spec
        # 需要澄清时向用户发起结构化问卷
        pkgs.pi-extensions.ask-user-question.spec
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
