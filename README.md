# bnna-template

Custom Alpine and Ubuntu container filesystems and images

# Building a New Image

1. List available images

    ```sh
    # fetches from http://download.proxmox.com/images/aplinfo-pve-8.dat
    #          and https://releases.turnkeylinux.org/pve/aplinfo.dat
    pveam update
    pveam available --section system
    ```

    The versioned URL is stored in `/usr/share/perl5/PVE/APLInfo.pm`, and
    can be manually updated to get the latest images on an older system (caveats may apply).

2. Download the desired images

    ```sh
    # 'local' refes to /var/lib/vz/template/cache/
    # cephfs0 refers to /mnt/pve/cephfs0/template/cache/
    pveam download cephfs0 ubuntu-22.04-standard_22.04-1_amd64.tar.zst
    pveam download cephfs0 ubuntu-24.04-standard_24.04-2_amd64.tar.zst
    pveam download cephfs0 alpine-3.18-default_20230607_amd64.tar.xz
    pveam download cephfs0 alpine-3.19-default_20240207_amd64.tar.xz
    ```

    This is functionally equivalent to using `wget` with these URLs: \
    (although `pveam download` also checks the checksums)

    ```sh
    pushd /mnt/pve/cephfs0/template/cache/
    b_base_url="http://download.proxmox.com/images/system"
    wget -c "${b_base_url}"/ubuntu-22.04-standard_22.04-1_amd64.tar.zst
    wget -c "${b_base_url}"/ubuntu-24.04-standard_24.04-2_amd64.tar.zst
    wget -c "${b_base_url}"/alpine-3.18-default_20230607_amd64.tar.xz
    wget -c "${b_base_url}"/alpine-3.19-default_20240207_amd64.tar.xz
    ```

3. Unpack an image to customize \
   (and another to keep for reference)
    ```sh
    mkdir -p ./ubuntu-24.04-bnna/
    tar xvf ./ubuntu-24.04-standard_*_amd64.tar.* -C ./ubuntu-24.04-bnna/
    ```
    ```sh
    # for reference
    mkdir -p ./ubuntu-24.04-standard/
    tar xvf ./ubuntu-24.04-standard_*_amd64.tar.* -C ./ubuntu-24.04-standard/
    ```

How Proxmox customizes containers:

-   <https://pve.proxmox.com/pve-docs/chapter-pct.html#_guest_operating_system_configuration>
