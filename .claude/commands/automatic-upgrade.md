# automatic-upgrade

Automatically upgrade flake.lock and NixOS system components to their latest versions.

## Arguments

$ARGUMENTS can contain:
- Empty: update flake.lock only (`nix flake update`)
- Input names: `nixpkgs home-manager` - update specific flake inputs
- Component names: `nixos home-manager nixos-wsl` - upgrade specific components to latest tags
- `all` - update everything (flake.lock + all components + stateVersion)

## Usage

When user requests to upgrade system components, follow this systematic process:

### 1. Parse Arguments
Parse $ARGUMENTS to determine upgrade scope:
- If empty: run `nix flake update` only
- If contains input names: run `nix flake update input1 input2`
- If contains component names: upgrade specific components to latest stable tags
- If contains `all`: perform complete system upgrade

### 2. Backup Current State
Before making changes:
1. Check current git status
2. Create backup branch if needed: `git checkout -b backup-before-upgrade-$(date +%Y%m%d)`
3. Record current flake.lock state

### 3. Update Flake Lock
Based on scope:
- **Default**: `nix flake update`
- **Specific inputs**: `nix flake update input1 input2`
- **Component upgrade**: Update specific inputs to latest stable tags

### 4. Component Version Upgrade (if requested)
When upgrading system components, update to latest stable tags:

**NixOS (nixpkgs)**:
- Find latest stable release tag (e.g., `24.05`, `24.11`)
- Update nixpkgs input to latest stable release
- Update all system.stateVersion references

**Home Manager**:
- Find latest release tag matching NixOS version
- Update home-manager input to corresponding stable tag
- Update all home.stateVersion references

**NixOS-WSL**:
- Find latest release tag from nixos-wsl repository
- Update nixos-wsl input to latest stable tag
- No stateVersion changes needed for WSL

**Other Components**:
- Identify component type and repository
- Find latest stable/release tag
- Update corresponding flake input

### 5. Scan and Update StateVersion
Search for stateVersion in all configuration files:
- `hosts/*/configuration.nix`
- `hosts/*/default.nix` 
- `users/*/home.nix`
- Any other .nix files containing `stateVersion`

Update patterns based on component:
```nix
# NixOS system stateVersion (matches NixOS release)
system.stateVersion = "24.05";

# Home Manager stateVersion (matches Home Manager release)
home.stateVersion = "24.05";
```

### 6. Verify Configuration
Run validation checks:
1. `nix flake check` - ensure flake is valid and all configurations build correctly
2. Report any build errors or warnings

### 7. Report Results
Provide summary showing:
- Flake inputs updated (old → new versions/tags)
- Component versions upgraded (NixOS, Home Manager, NixOS-WSL, etc.)
- StateVersion updates made
- Flake check results
- Any errors encountered

## Supported Components

### NixOS (nixpkgs)
- Repository: `github:NixOS/nixpkgs`
- Latest stable tags: `24.05`, `24.11`, etc.
- Updates: `system.stateVersion`

### Home Manager
- Repository: `github:nix-community/home-manager`
- Latest release tags: `release-24.05`, `release-24.11`, etc.
- Updates: `home.stateVersion`

### NixOS-WSL
- Repository: `github:nix-community/NixOS-WSL`
- Latest release tags: `24.05.5`, `24.11.1`, etc.
- Updates: No stateVersion changes

### Other Components
- Automatically detect repository from flake inputs
- Find latest release/stable tags
- Update to most recent stable version

## StateVersion Detection Patterns

### NixOS System StateVersion
```nix
system.stateVersion = "23.11";
```

### Home Manager StateVersion
```nix
home.stateVersion = "23.11";
```

### Common Locations
- `/etc/nixos/hosts/*/configuration.nix`
- `/etc/nixos/hosts/*/default.nix`
- `/etc/nixos/users/*/home.nix`
- `/etc/nixos/modules/*/default.nix`

## Version Mapping Examples
- NixOS 24.05 → system.stateVersion "24.05"
- Home Manager release-24.05 → home.stateVersion "24.05"
- NixOS-WSL 24.05.5 → no stateVersion change needed

## Error Handling
- If flake update fails, report error and stop
- If specific input doesn't exist, skip with warning
- If latest tag cannot be determined, skip with error
- If build fails for a host, report but continue with others
- If stateVersion file is read-only, report and skip
- Always provide clear status for each operation

## Rollback Information
After upgrade, provide rollback instructions:
```
To rollback if issues occur:
1. git checkout backup-before-upgrade-YYYYMMDD
2. nix flake update --commit-lock-file
3. nixos-rebuild switch --flake .#hostname
```

## Safety Checks
- Verify git working directory is clean before starting
- Create backup branch automatically
- Run dry-build before suggesting actual rebuild
- Warn about major version upgrades
- Provide clear rollback instructions
