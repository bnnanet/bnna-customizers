#!/bin/sh
set -e
set -u

g_tmpdir_default="/mnt/pve/cephfs0/template/cache.tmp"
g_tarball="${1:-}"
g_tmpdir="${2:-}"

fn_help() { (
    echo ""
    echo "USAGE"
    echo "  ${0} <alpine-tarball> [unpack dir]"
    echo ""
    echo "EXAMPLES"
    echo "  ${0} ./template/cache/alpine-3.20-default_20240908_amd64.tar.xz"
    echo "  ${0} ./template/cache/alpine-3.20-default_20240908_amd64.tar.xz ./alpine-3.20-bnna/"
    echo ""
); }

main() { (
    if test -z "${g_tarball}"; then
        fn_help >&2
        return 1
    fi

    if test -z "${g_tmpdir}"; then
        b_basename="$(basename "${g_tarball}" | rev | cut -d. -f3- | rev)"
        mkdir -p "${g_tmpdir_default}"
        g_tmpdir="${g_tmpdir_default}/${b_basename}"
    fi

    if test -e "${g_tmpdir}"; then
        echo >&2 "custom image directory already exists"
        echo >&2 "to continue remove '${g_tmpdir}'"
        return 1
    fi
    mkdir -p "${g_tmpdir}"

    printf '%s' "Unpacking ${g_tarball}... "
    tar xf "${g_tarball}" -C "${g_tmpdir}"
    echo "${g_tmpdir}"
); }

main
