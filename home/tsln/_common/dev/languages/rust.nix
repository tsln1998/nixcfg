{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.stable.latest.minimal.override {
      targets = [
        # Linux x64
        # "x86_64-unknown-linux-gnu"
        # Linux aarch64
        # "aarch64-unknown-linux-gnu"
        # macOS x64
        # "x86_64-apple-darwin"
        # macOS aarch64
        # "aarch64-apple-darwin"
        # Windows x64
        # "x86_64-pc-windows-msvc"
        # Windows aarch64
        # "aarch64-pc-windows-msvc"
      ];
    })

    rustfmt
  ];
}
