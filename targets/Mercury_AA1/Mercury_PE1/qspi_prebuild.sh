EBE_OVERLAYS="$1"

mkdir -p "$EBE_OVERLAYS/etc"
echo '/dev/mtd0 0xd00000 0x1000 0x40000' > "$EBE_OVERLAYS/etc/fw_env.config"

