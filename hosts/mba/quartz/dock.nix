{ config, ... }:
let
  home = config.home-manager.users.${config.system.primaryUser};
  applicationsUser = "${home.home.homeDirectory}/${home.targets.darwin.copyApps.directory}";
  applicationsSystem = "/Applications";
in
{
  system.defaults.dock = {
    # 按照下列顺序固定 Dock 中的应用。
    persistent-apps = [
      {
        app = "/System/Applications/Apps.app";
      }
      {
        app = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
      }
      {
        app = "${applicationsUser}/Google Chrome.app";
      }
      {
        app = "${applicationsUser}/QQ.app";
      }
      {
        app = "${applicationsUser}/WeChat.app";
      }
      {
        app = "${applicationsUser}/Feishu.app";
      }
      {
        app = "${applicationsUser}/Alacritty.app";
      }
      {
        app = "${applicationsUser}/FlClash.app";
      }
      {
        app = "${applicationsUser}/Notion.app";
      }
      {
        app = "${applicationsUser}/ChatGPT.app";
      }
      {
        app = "${applicationsUser}/Visual Studio Code.app";
      }
      {
        app = "${applicationsSystem}/Microsoft Outlook.app";
      }
      {
        app = "${applicationsSystem}/Microsoft Word.app";
      }
      {
        app = "${applicationsSystem}/Microsoft Excel.app";
      }
      {
        app = "${applicationsSystem}/OneDrive.app";
      }
      {
        app = "${applicationsUser}/Cyberduck.app";
      }
      {
        app = "${applicationsUser}/TablePlus.app";
      }
    ];
  };
}
