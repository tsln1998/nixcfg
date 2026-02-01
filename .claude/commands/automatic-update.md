# automatic-update

Automatically update packages in `/etc/nixos/packages/` to their latest versions.

## Arguments

$ARGUMENTS can contain:
- Package names: `foo bar` - update specific packages
- Directory names: `foo/` - update all packages in directory
- Empty: update all packages

## Usage

When user requests to update packages, follow this systematic process:

### 1. Parse Arguments
Parse $ARGUMENTS to determine scope:
- If empty: update all packages
- If contains package names: update only those packages  
- If contains directory names (ending with "/"): update all packages in those directories

### 2. Scan Package Structure
Discover all .nix files in the specified scope within packages directory.

### 3. Identify Package Types
Read each .nix file to determine package type:

**GitHub Go Projects** (buildGoModule + fetchFromGitHub):
- Look for: `buildGoModule`, `fetchFromGitHub`, `vendorHash`
- Repository: extract `owner` and `repo` variables
- Update fields: `version`, `hash`, `vendorHash`

**GitHub Release Files** (fetchurl):
- Look for: `fetchurl`, direct download URLs
- Repository: extract from URL pattern
- Update fields: `version`, `hash`

**VS Code Extensions** (buildVscodeMarketplaceExtension):
- Look for: `buildVscodeMarketplaceExtension`, `mktplcRef`
- Publisher/Name: extract from `mktplcRef`
- Update fields: `version`, `hash`

### 4. Fetch Latest Versions
For each package type, get latest version information:

**GitHub packages**: 
- Check releases page: `https://github.com/{owner}/{repo}/releases`
- Look for latest tag/version number

**VS Code extensions**: 
- Check VS Code Marketplace for latest version

### 5. Update Package Files
For each outdated package:
1. Update version numbers in .nix files
2. Set hashes to placeholder: `"sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="`
3. Run `nix build .#{package-name}` to get correct hashes from error messages
4. Update with correct hashes
5. For Go packages, also update `vendorHash` if needed

### 6. Verify Builds
Run `nix build .#{package-name}` for each updated package to ensure successful builds.

### 7. Report Results
Provide summary showing:
- Total packages scanned
- Version changes (old → new)
- Build test results
- Any errors encountered

## Package Type Detection Patterns

### GitHub Go Project
```nix
buildGoModule rec {
  pname = "foobar";
  version = "1.0.0";
  
  src = fetchFromGitHub {
    owner = "foobar";
    repo = "foobar";
    rev = "refs/tags/v${version}";
    hash = "sha256-...";
  };
  
  vendorHash = "sha256-...";
}
```

### GitHub Release File
```nix
stdenvNoCC.mkDerivation rec {
  pname = "foobar";
  version = "1.0.0";
  
  src = fetchurl {
    url = "https://github.com/foobar/foobar/releases/download/v${version}/file.html";
    hash = "sha256-...";
  };
}
```

### VS Code Extension
```nix
buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "foobar";
    name = "foobar";
    version = "1.0.0";
    hash = "sha256-...";
  };
}
```

## Error Handling
- If package type cannot be determined, skip with warning
- If latest version cannot be fetched, skip with error message  
- If build fails, report error but continue with other packages
- Always provide clear status for each package processed

## Hash Update Process
1. Replace hash with placeholder
2. Run nix build command
3. Extract correct hash from error message
4. Update .nix file with correct hash
5. Verify build succeeds
