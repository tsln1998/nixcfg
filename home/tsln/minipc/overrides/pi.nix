_: {
  programs.pi.settings.packages = [
    # 多智能体团队协作、工作流与任务编排
    "npm:pi-crew"
    # 网页搜索、URL 抓取及文档、视频内容提取
    "npm:pi-web-access"
    # 连接并调用 MCP（模型上下文协议）服务
    "npm:pi-mcp-adapter"
    # 在底栏显示模型、路径、Git、令牌、费用及耗时
    "npm:pi-cometix-footer"
    # 通过检索与沙盒执行减少上下文占用
    "npm:context-mode"
    # 启用“少写代码”的资深开发模式
    "npm:@dietrichgebert/ponytail"
    # 需要澄清时向用户发起结构化问卷
    "npm:@juicesharp/rpiv-ask-user-question"
  ];
}
