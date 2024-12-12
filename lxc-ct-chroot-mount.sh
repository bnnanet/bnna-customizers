#!/bin/sh
set -e
set -u

g_chroot_dir="${1:-}"

fn_help() { (
    echo ""
    echo "USAGE"
    echo "  ${0} <chroot-dir>"
    echo ""
    echo "EXAMPLE"
    echo "  ${0} ./template/cache.tmp/alpine-3.20-default_20240908_amd64/"
    echo ""
); }

main() { (
    if test -z "${g_chroot_dir}"; then
        fn_help >&2
        return 1
    fi

    printf '%s' "Preparing ${g_chroot_dir}... "
    cd "${g_chroot_dir}"

    mount -t proc /proc ./proc/

    mount --rbind /sys ./sys/
    mount --make-rslave ./sys/

    mount --rbind /dev ./dev/
    mount --make-rslave ./dev/
); }

main
