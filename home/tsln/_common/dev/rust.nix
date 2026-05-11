{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override {
      targets = [
        "x86_64-unknown-linux-gnu"   # Linux x64
        "aarch64-unknown-linux-gnu"  # Linux aarch64
        "x86_64-apple-darwin"        # macOS x64
        "aarch64-apple-darwin"       # macOS aarch64
        "x86_64-pc-windows-msvc"     # Windows x64
        "aarch64-pc-windows-msvc"    # Windows aarch64
       ];
    })
    
    lld

    cargo-workspaces
    cargo-generate
  ];
}
