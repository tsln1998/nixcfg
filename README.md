# Install (NixOS)

# Install (NixOS with disko)

```bash
# run disko
sudo nix --extra-experimental-features "nix-command flakes" \
    run 'github:nix-community/disko/v1.11.0' \
    -- \
    --mode destroy,format,mount \
    ./hosts/<hostname>/disks.nix

# copy ssh keys in to /mnt/tmp/*
# ...

# run nixos-install
sudo nixos-install --no-root-password --flake '.#<hostname>'
```

# Install (NixOS on WSL)

```bash
sudo nixos-rebuild switch --flake '.#<hostname>'
```