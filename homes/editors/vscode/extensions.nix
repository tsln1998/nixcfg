{ pkgs, ... }:
{
  programs.vscode.extensions =
    (with pkgs.vscode-extensions; [
      ms-vscode.hexeditor
      redhat.vscode-xml
      redhat.vscode-yaml
      tamasfe.even-better-toml
      mechatroner.rainbow-csv
      editorconfig.editorconfig
      quicktype.quicktype
      humao.rest-client
    ])
    ++ (with pkgs.unstable.vscode-extensions; [ fill-labs.dependi ]);
}
