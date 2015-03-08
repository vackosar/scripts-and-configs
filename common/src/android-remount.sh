grep " /system " /proc/mounts | awk '{system("mount -o rw,remount -t "$3" "$1" "$2)}'
