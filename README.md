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

    <details><summary>Sample Output</summary>
    <pre><code>
    update successful
    system          almalinux-9-default_20240911_amd64.tar.xz
    system          alpine-3.18-default_20230607_amd64.tar.xz
    system          alpine-3.19-default_20240207_amd64.tar.xz
    system          alpine-3.20-default_20240908_amd64.tar.xz
    system          archlinux-base_20240911-1_amd64.tar.zst
    system          centos-9-stream-default_20240828_amd64.tar.xz
    system          debian-11-standard_11.7-1_amd64.tar.zst
    system          debian-12-standard_12.7-1_amd64.tar.zst
    system          devuan-5.0-standard_5.0_amd64.tar.gz
    system          fedora-39-default_20231118_amd64.tar.xz
    system          fedora-40-default_20240909_amd64.tar.xz
    system          gentoo-current-openrc_20231009_amd64.tar.xz
    system          opensuse-15.5-default_20231118_amd64.tar.xz
    system          opensuse-15.6-default_20240910_amd64.tar.xz
    system          rockylinux-9-default_20240912_amd64.tar.xz
    system          ubuntu-20.04-standard_20.04-1_amd64.tar.gz
    system          ubuntu-22.04-standard_22.04-1_amd64.tar.zst
    system          ubuntu-24.04-standard_24.04-2_amd64.tar.zst
    </code></pre>
    </details>

2. Download the desired images

    ```sh
    # 'local' refes to /var/lib/vz/template/cache/
    # cephfs0 refers to /mnt/pve/cephfs0/template/cache/
    pveam download cephfs0 ubuntu-22.04-standard_22.04-1_amd64.tar.zst
    pveam download cephfs0 ubuntu-24.04-standard_24.04-2_amd64.tar.zst
    pveam download cephfs0 devuan-5.0-standard_5.0_amd64.tar.gz
    pveam download cephfs0 alpine-3.18-default_20230607_amd64.tar.xz
    pveam download cephfs0 alpine-3.19-default_20240207_amd64.tar.xz
    pveam download cephfs0 alpine-3.20-default_20240908_amd64.tar.xz
    ```

    This is functionally equivalent to using `wget` with these URLs: \
    (although `pveam download` also checks the checksums)

    ```sh
    pushd /mnt/pve/cephfs0/template/cache/
    b_base_url="http://download.proxmox.com/images/system"
    wget -c "${b_base_url}"/ubuntu-22.04-standard_22.04-1_amd64.tar.zst
    wget -c "${b_base_url}"/ubuntu-24.04-standard_24.04-2_amd64.tar.zst
    wget -c "${b_base_url}"/devuan-5.0-standard_5.0_amd64.tar.gz
    wget -c "${b_base_url}"/alpine-3.18-default_20230607_amd64.tar.xz
    wget -c "${b_base_url}"/alpine-3.19-default_20240207_amd64.tar.xz
    wget -c "${b_base_url}"/alpine-3.20-default_20240908_amd64.tar.xz
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
