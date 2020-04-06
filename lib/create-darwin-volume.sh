#!/usr/bin/env bash
#
# Originally copied from here:
# https://github.com/cachix/install-nix-action/blob/ebed63b0a20f20951a06a507ea1a1596bfce35b6/lib/create-darwin-volume.sh
#
set -e

root_disks() {
    diskutil list -plist /
}

apfs_volumes_for() {
    disk=$1
    diskutil apfs list -plist "$disk"
}

disk_identifier() {
    xpath "/plist/dict/key[text()='WholeDisks']/following-sibling::array[1]/string/text()" 2>/dev/null
}

volume_get() {
    key=$1 i=$2
    xpath "/plist/dict/array/dict/key[text()='Volumes']/following-sibling::array/dict[$i]/key[text()='$key']/following-sibling::string[1]/text()" 2> /dev/null
}

find_nix_volume() {
    disk=$1
    i=1
    volumes=$(apfs_volumes_for "$disk")
    while true; do
        name=$(echo "$volumes" | volume_get "Name" "$i")
        if [ -z "$name" ]; then
            break
        fi
        case "$name" in
            [Nn]ix*)
                echo "$name"
                break
                ;;
        esac
        i=$((i+1))
    done
}

test_fstab() {
    grep -q "/nix" /etc/fstab 2>/dev/null
}

test_synthetic_conf() {
    grep -q "^nix" /etc/synthetic.conf 2>/dev/null
}

test_nix() {
    test -d "/nix"
}

main() {
    (
        echo ""
        echo "     ------------------------------------------------------------------ "
        echo "    | This installer will create a volume for the nix store and        |"
        echo "    | configure it to mount at /nix.  Follow these steps to uninstall. |"
        echo "     ------------------------------------------------------------------ "
        echo ""
        echo "  1. Remove the entry from fstab using 'sudo vifs'"
        echo "  2. Destroy the data volume using 'diskutil apfs deleteVolume'"
        echo "  3. Delete /etc/synthetic.conf"
        echo ""
    ) >&2

    if [ -L "/nix" ]; then
        echo "error: /nix is a symlink, please remove it or edit synthetic.conf (requires reboot)" >&2
        echo "  /nix -> $(readlink "/nix")" >&2
        exit 2
    fi

    if ! test_synthetic_conf; then
        echo "Configuring /etc/synthetic.conf..." >&2
        echo nix | sudo tee /etc/synthetic.conf
        /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -B
    fi

    if ! test_nix; then
        echo "Creating mountpoint for /nix..." >&2
        sudo mkdir /nix
    fi

    disk=$(root_disks | disk_identifier)
    volume=$(find_nix_volume "$disk")
    if [ -z "$volume" ]; then
        echo "Creating a Nix Store volume..." >&2
        sudo diskutil apfs addVolume "$disk" APFS 'Nix Store' -mountpoint /nix
        volume="Nix Store"
    else
        echo "Using existing '$volume' volume" >&2
    fi

    if ! test_fstab; then
        echo "Configuring /etc/fstab..." >&2
        label=$(echo "$volume" | sed 's/ /\\040/g')
        printf "\$a\nLABEL=%s /nix apfs rw\n.\nwq\n" "$label" | EDITOR=ed sudo vifs
        sudo defaults write /Library/Preferences/SystemConfiguration/autodiskmount AutomountDisksWithoutUserLogin -bool true
    fi
}

main "$@"
