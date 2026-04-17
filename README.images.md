# Disko images snippets

> Minimum memory requirement 128MB or more
>
> If the device has sufficient memory, deployment using the NixOS-Anywhere method is recommended.

## Build disko image

```bash
# generate script
nix build '.#nixosConfigurations.oracle-phx-1.config.system.build.diskoImagesScript'
# generate image
./result
```

## Burning Disko image

```bash
tar -Scf - main.raw | \
  ssh root@oracle-phx-1 'tar -xOf - main.raw | dd of=/dev/sda bs=64M status=progress conv=fsync'
```

## Grow filesystem

```bash
sudo swapoff -a
sudo fdisk /dev/sda         # > p > d > n > N > p > w
sudo pvresize /dev/sda2
sudo lvextend -L 1G /dev/mapper/pool-boot
sudo lvextend -L 4G /dev/mapper/pool-persist
sudo lvextend -L 32G /dev/mapper/pool-nix
sudo lvextend -L 4G /dev/mapper/pool-swap
sudo resize2fs /dev/mapper/pool-boot
sudo resize2fs /dev/mapper/pool-persist
sudo resize2fs /dev/mapper/pool-nix
sudo mkswap /dev/mapper/pool-swap
sudo swapon /dev/mapper/pool-swap
```

## Rebuild system

```bash
scp ~/.ssh/id_ed25519 tsln@oracle-phx-1:/tmp

sudo nixos-rebuild test \
  --flake github:tsln1998/nixcfg#oracle-phx-1

sudo nixos-rebuild boot \
  --flake github:tsln1998/nixcfg#oracle-phx-1
```
