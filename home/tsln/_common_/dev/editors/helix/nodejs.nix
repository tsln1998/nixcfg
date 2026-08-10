{ pkgs, ... }:
let
  formatter = {
    command = "prettierd";
    args = [ "%{buffer_name}" ];
  };
  languageServers = [
    {
      name = "typescript-language-server";
      except-features = [ "format" ];
    }
    {
      name = "vscode-eslint-language-server";
      except-features = [ "format" ];
    }
  ];
in
{
  programs.helix = {
    extraPackages = with pkgs; [
      typescript-language-server
      vscode-langservers-extracted
      prettierd
    ];

    languages.language = [
      {
        name = "javascript";
        auto-format = true;
        inherit formatter;
        language-servers = languageServers;
      }
      {
        name = "jsx";
        auto-format = true;
        inherit formatter;
        language-servers = languageServers;
      }
      {
        name = "typescript";
        auto-format = true;
        inherit formatter;
        language-servers = languageServers;
      }
      {
        name = "tsx";
        auto-format = true;
        inherit formatter;
        language-servers = languageServers;
      }
      {
        name = "json";
        auto-format = true;
        inherit formatter;
      }
      {
        name = "jsonc";
        auto-format = true;
        inherit formatter;
      }
      {
        name = "css";
        auto-format = true;
        inherit formatter;
      }
      {
        name = "scss";
        auto-format = true;
        inherit formatter;
      }
      {
        name = "html";
        auto-format = true;
        inherit formatter;
        language-servers = [ "vscode-html-language-server" ];
      }
    ];
  };
}
