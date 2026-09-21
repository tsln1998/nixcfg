{ pkgs, ... }: {
  programs.pi.extraPackages = [
    # for pi-rtk-optimizer
    pkgs.rtk
    # for plannotator/pi-extension
    pkgs.python3
  ];

  programs.pi.settings.packages = [
    # 网页搜索、URL 抓取及文档、视频内容提取
    "npm:pi-web-access@0.30.0"
    # 连接并调用 MCP（模型上下文协议）服务
    "npm:pi-mcp-adapter@2.35.0"
    # 命令输出过滤，节省 Token 用量并提升速度
    "npm:pi-rtk-optimizer@0.9.0"
    # 在底栏显示模型、路径、Git、令牌、费用及耗时
    "npm:pi-cometix-footer@1.1.1"
    # 通过检索与沙盒执行减少上下文占用
    "npm:context-mode@1.0.169"
    # 只读探索代码库，并在执行前先制定计划
    "npm:@plannotator/pi-extension@0.27.16"
    # 自动重试错误
    "npm:@monotykamary/pi-retry@0.10.1"
    # 启用“少写代码”的资深开发模式
    "npm:@dietrichgebert/ponytail@4.10.0"
    # 展示任务列表
    "npm:@juicesharp/rpiv-todo@2.10.1"
    # 需要澄清时向用户发起结构化问卷
    "npm:@juicesharp/rpiv-ask-user-question@2.10.1"
  ];

  programs.pi.settings.piRetry = {
    baseDelayMs = 1000;
    maxDelayMs = 60000;
    multiplier = 2;
    maxRetriesAtMaxDelay = 60;
  };
}
