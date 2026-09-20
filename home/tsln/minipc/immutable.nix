{
  home.persistence."/persist" = {
    directories = [
      # Secrets
      {
        directory = ".ssh";
        mode = "0700";
      }

      # User data
      "Codebases"
      "Downloads"

      # Atuin
      ".atuin"
      ".local/share/atuin"

      # Beekeeper Studio
      ".config/beekeeper-studio"

      # Buf
      ".cache/buf"

      # Chromium
      ".config/chromium"
      ".cache/chromium"

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
      ".local/state/herdr"

      # Keyring
      ".local/state/keyring"

      # Nali
      ".local/share/nali"

      # Nix
      ".cache/nix"
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

      # OnlyOffice
      ".local/share/onlyoffice"

      # OpenLogi
      ".local/share/openlogi"

      # Pi
      ".pi"

      # Baloo (Plasma Search)
      ".local/share/baloo"

      # Podman and Docker
      ".docker"
      ".local/share/containers"

      # Python and uv
      ".cache/pip"
      ".cache/uv"
      ".local/share/uv"

      # Rust
      ".cargo"

      # VS Code (included remote access)
      ".vscode"
      ".vscode-server"
      ".vscode-shared"

      # Zoxide
      ".local/share/zoxide"
    ];

    files = [ ];

    # Ungroupped
    # ".agents"
    # ".claude"
    # ".dolt"
    # ".config/Code"
    # ".config/Codex"
    # ".config/DenysMb"
    # ".config/KDE"
    # ".config/LarkShell"
    # ".config/atuin"
    # ".config/autostart"
    # ".config/bat"
    # ".config/bd"
    # ".config/bruno"
    # ".config/btop"
    # ".config/chromium-headless"
    # ".config/codemod"
    # ".config/configstore"
    # ".config/containers"
    # ".config/dconf"
    # ".config/direnv"
    # ".config/dlv"
    # ".config/environment.d"
    # ".config/evolution"
    # ".config/eza"
    # ".config/fcitx"
    # ".config/fcitx5"
    # ".config/flutter"
    # ".config/fontconfig"
    # ".config/git"
    # ".config/gitui"
    # ".config/go"
    # ".config/goa-1.0"
    # ".config/gopls"
    # ".config/gtk-3.0"
    # ".config/gtk-4.0"
    # ".config/helix"
    # ".config/herdr"
    # ".config/htop"
    # ".config/ibus"
    # ".config/k9s"
    # ".config/kate"
    # ".config/kdedefaults"
    # ".config/kdiskmark"
    # ".config/lazygit"
    # ".config/lazyworktree"
    # ".config/libvirt"
    # ".config/matplotlib"
    # ".config/nali"
    # ".config/nix"
    # ".config/nixpkgs"
    # ".config/nx"
    # ".config/obsidian"
    # ".config/onlyoffice"
    # ".config/openlogi"
    # ".config/opencode"
    # ".config/openspec"
    # ".config/org.gnome.Ptyxis"
    # ".config/plasma-workspace"
    # ".config/pnpm"
    # ".config/podman"
    # ".config/pulse"
    # ".config/qtvirtualkeyboard"
    # ".config/session"
    # ".config/surgio"
    # ".config/systemd"
    # ".config/tanstack"
    # ".config/tmux"
    # ".config/uv"
    # ".config/vlc"
    # ".config/xsettingsd"
    # ".config/zellij"
    # ".cache/Codex"
    # ".cache/DenysMb"
    # ".cache/JNA"
    # ".cache/KDE"
    # ".cache/Microsoft"
    # ".cache/QtLocation"
    # ".cache/appstream"
    # ".cache/bat"
    # ".cache/bookmarksrunner"
    # ".cache/chromium-headless"
    # ".cache/claude-cli-nodejs"
    # ".cache/cobrapy"
    # ".cache/codex-go-tmp"
    # ".cache/conda"
    # ".cache/containers"
    # ".cache/ddcutil"
    # ".cache/deno"
    # ".cache/discover"
    # ".cache/distrobox"
    # ".cache/dolphin"
    # ".cache/drkonqi"
    # ".cache/evolution"
    # ".cache/fastfetch"
    # ".cache/gaphor"
    # ".cache/gnome-disks"
    # ".cache/go-build2759891538"
    # ".cache/gstreamer-1.0"
    # ".cache/gtk-4.0"
    # ".cache/helix"
    # ".cache/hyfetch"
    # ".cache/ibus"
    # ".cache/jedi"
    # ".cache/kalk"
    # ".cache/kcmshell6"
    # ".cache/kcrash-metadata"
    # ".cache/kinfocenter"
    # ".cache/koko"
    # ".cache/krunner"
    # ".cache/kscreen_osd_service"
    # ".cache/kscreenlocker_greet"
    # ".cache/ksmserver-logout-greeter"
    # ".cache/ksplash"
    # ".cache/kwin"
    # ".cache/libvirt"
    # ".cache/mamba"
    # ".cache/matplotlib"
    # ".cache/mesa_shader_cache"
    # ".cache/ms-playwright-go"
    # ".cache/nvim"
    # ".cache/obexd"
    # ".cache/onedriver"
    # ".cache/org.kde.kunifiedpush"
    # ".cache/org.kde.unitconversion"
    # ".cache/plasma-systemmonitor"
    # ".cache/plasmashell"
    # ".cache/polkit-kde-authentication-agent-1"
    # ".cache/qmd"
    # ".cache/qtshadercache-x86_64-little_endian-lp64"
    # ".cache/radv_builtin_shaders"
    # ".cache/skanpage"
    # ".cache/snowflake"
    # ".cache/spectacle"
    # ".cache/starship"
    # ".cache/systemsettings"
    # ".cache/thumbnails"
    # ".cache/tracker3"
    # ".cache/treefmt"
    # ".cache/vscode-cpptools"
    # ".cache/xdg-desktop-portal-kde"
    # ".cache/zellij"
    # ".local/share/ark"
    # ".local/share/dolphin"
    # ".local/share/drkonqi"
    # ".local/share/evolution"
    # ".local/share/flatpak"
    # ".local/share/fonts"
    # ".local/share/gitcomet"
    # ".local/share/gnome-remote-desktop"
    # ".local/share/gnome-settings-daemon"
    # ".local/share/gnome-shell"
    # ".local/share/gvfs-metadata"
    # ".local/share/gwenview"
    # ".local/share/icc"
    # ".local/share/k9s"
    # ".local/share/kactivitymanagerd"
    # ".local/share/kate"
    # ".local/share/kded6"
    # ".local/share/keyrings"
    # ".local/share/klipper"
    # ".local/share/knewstuff3"
    # ".local/share/koko"
    # ".local/share/konsole"
    # ".local/share/krdpserver"
    # ".local/share/kscreen"
    # ".local/share/kwalletd"
    # ".local/share/kwrite"
    # ".local/share/kxmlgui5"
    # ".local/share/lazyworktree"
    # ".local/share/libkunitconversion"
    # ".local/share/nix"
    # ".local/share/nvim"
    # ".local/share/okular"
    # ".local/share/org.gnome.Ptyxis"
    # ".local/share/pki"
    # ".local/share/plasma-manager"
    # ".local/share/plasma-systemmonitor"
    # ".local/share/remoteview"
    # ".local/share/rtk"
    # ".local/share/sddm"
    # ".local/share/sounds"
    # ".local/share/systemd"
    # ".local/share/vlc"
    # ".local/share/worktrees"
    # ".local/share/xrdp"
    # ".local/state/hermes"
    # ".local/state/home-manager"
    # ".local/state/k9s"
    # ".local/state/keyring-rs"
    # ".local/state/lazygit"
    # ".local/state/nix-output-monitor"
    # ".local/state/nvim"
    # ".local/state/wireplumber"
    # ".local/state/yazi"

    # Ungroupped files
    # ".config/kdeglobals"
    # ".config/kglobalshortcutsrc"
    # ".config/kwinoutputconfig.json"
    # ".config/plasma-org.kde.plasma.desktop-appletsrc"
    # ".local/share/user-places.xbel"
    # ".local/share/user-places.xbel.bak"
    # ".local/share/recently-used.xbel"
  };
}
