{
  home.persistence."/persist" = {
    directories = [
      # Secrets
      {
        directory = ".ssh";
        mode = "0700";
      }

      # GNOME Keyring
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }

      # KWallet
      {
        directory = ".local/share/kwalletd";
        mode = "0700";
      }

      # User data
      "Codebases"
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"

      # Atuin
      ".atuin"
      ".local/share/atuin"

      # Beekeeper Studio
      ".config/beekeeper-studio"

      # Bruno
      ".config/bruno"

      # Buf
      ".cache/buf"

      # Chromium
      ".config/chromium"
      ".cache/chromium"

      # PKI
      ".pki"
      ".local/share/pki"

      # Codegraph
      ".codegraph"

      # Codex
      ".codex"
      ".cache/codex-runtimes"
      ".local/state/codex"

      # Direnv
      ".local/share/direnv/allow"

      # Fcitx5
      ".local/share/fcitx5"

      # Feishu
      ".cache/LarkShell"
      ".config/LarkShell"

      # Flutter
      ".pub-cache"

      # Fontconfig
      ".cache/fontconfig"

      # GitComet
      ".local/state/gitcomet"

      # Go
      ".go"
      ".cache/go-build"
      ".cache/goimports"
      ".cache/golangci-lint"
      ".cache/gopls"

      # Gradle
      ".gradle"

      # Herdr
      ".config/herdr"
      ".local/state/herdr"

      # Keyring
      ".local/state/keyring"

      # Nali
      ".local/share/nali"

      # Nix
      ".cache/nix"
      ".local/share/nix"
      ".local/state/nix"

      # Node.js and Package Manager
      ".npm"
      ".cache/node"
      ".cache/node-gyp"
      ".cache/typescript"
      ".cache/yarn"
      ".cache/.pnpm-store"
      ".cache/pnpm"
      ".local/share/pnpm"
      ".local/state/pnpm"

      # LibreOffice
      ".config/libreoffice"

      # Pi
      ".pi"

      # Podman and Docker
      ".docker"
      ".local/share/containers"

      # Python and uv
      ".cache/pip"
      ".cache/uv"
      ".cache/rattler"
      ".local/share/uv"

      # Rust
      ".cargo"

      # Systemd timers
      ".local/share/systemd/timers"

      # VLC
      ".config/vlc"

      # VS Code (included remote access)
      ".vscode"
      ".vscode-server"
      ".vscode-shared"
      ".config/Code"

      # Zoxide
      ".local/share/zoxide"

      # Bat
      ".cache/bat"

      # KDE Plasma
      ".local/share/ark"
      ".local/share/baloo"
      ".local/share/gwenview"
      ".local/share/kate"
      ".local/share/klipper"
      ".local/share/kwrite"
      ".local/share/kactivitymanagerd"
      ".cache/drkonqi"
      ".cache/thumbnails"
      ".cache/bookmarksrunner"
      ".cache/qtshadercache-x86_64-little-endian-lp64"

      # Mesa Shaders
      ".cache/mesa_shader_cache"
      ".cache/radv_builtin_shaders"

      # Android
      ".android"

      # Beads
      ".beads"

      # Kubernetes
      ".kube/cache"

      # Obsidian
      ".config/obsidian"

      # RTK
      ".local/share/rtk"

      # Treefmt
      ".cache/treefmt"

      # WirePlumber
      ".local/state/wireplumber"
    ];

    files = [
      # KWallet
      ".config/kwalletrc"
      ".local/state/kwalletmanagerstaterc"

      # KDE Plasma
      ".local/share/recently-used.xbel"
      ".local/share/user-places.xbel"
      ".cache/ksvg-elements"
      ".cache/plasma_theme_default.kcache"
    ];
  };
}
