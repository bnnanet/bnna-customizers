#!/bin/sh
set -e
set -u

echo ""

echo "Current LXC/CT Images"
echo ""
pveam list cephfs0
echo ""

printf "Checking for latest image list... "
pveam update
echo ""

echo "All Remote Images"
echo ""
g_all_images="$(pveam available --section system)"
# pveam available | grep -E 'alpine|ubuntu|devuan|rocky|alma' | sed 's:system::g' | tr -d ' '
echo "${g_all_images}"
echo ""

echo "Selected Images"
echo ""
g_distros="$(echo "${g_all_images}" | grep 'system ' | grep -E 'alpine|ubuntu-[23][02468]\.04|debian|devuan|rocky|alma' | sed 's:system::g' | tr -d ' ')"
echo "${g_distros}"
echo ""
#g_distros="almalinux-9-default_20240911_amd64.tar.xz
#alpine-3.18-default_20230607_amd64.tar.xz
#alpine-3.19-default_20240207_amd64.tar.xz
#alpine-3.20-default_20240908_amd64.tar.xz
#debian-11-standard_11.7-1_amd64.tar.zst
#debian-12-standard_12.7-1_amd64.tar.zst
#devuan-5.0-standard_5.0_amd64.tar.gz
#rockylinux-9-default_20240912_amd64.tar.xz
#ubuntu-20.04-standard_20.04-1_amd64.tar.gz
#ubuntu-22.04-standard_22.04-1_amd64.tar.zst
#ubuntu-24.04-standard_24.04-2_amd64.tar.zst"

echo "Syncing select images... "
echo ""
for b_distro in $g_distros; do
    pveam download cephfs0 "${b_distro}"
done
echo ""

echo "Latest LXC/CT Images"
echo ""
pveam list cephfs0
echo ""
