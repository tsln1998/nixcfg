# NixOS anywhere snippets

> Minimum memory requirement 2GB or more

## Deployment

```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake '.#oracle-phx-1' \
  --target-host root@oracle-phx-1 \
  --build-on local \
  --no-disko-deps \
  --phases 'kexec,disko,install,reboot'
```

## If the device has insufficient memory ?

> You can use the following command to enable zram to improve the success rate.

```bash
sudo -i <<'EOF'
systemctl stop auditd || true
systemctl stop crond || true
systemctl stop chronyd || true
systemctl stop rsyslog || true
systemctl stop polkit || true
systemctl stop systemd-userdbd || true

pkill -x watch || true

modprobe zram
echo 768M > /sys/block/zram0/disksize
mkswap /dev/zram0 || true
swapoff /dev/zram0 || true
swapon -p 100 /dev/zram0

sync
echo 3 > /proc/sys/vm/drop_caches

free -h
swapon --show
EOF
```