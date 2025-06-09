#!/bin/bash

SWAP_DEVICE="/dev/sdb"   

function status_swap() {
    echo "=== Swap Status ==="
    swapon --show
    free -h
}

function disable_swap() {
    echo "Disabling swap temporarily on $SWAP_DEVICE ..."
    sudo swapoff $SWAP_DEVICE
    echo "Swap status after disabling:"
    swapon --show
}

function enable_swap() {
    echo "Enabling swap temporarily on $SWAP_DEVICE ..."
    sudo swapon $SWAP_DEVICE
    echo "Swap status after enabling:"
    swapon --show
}

function wipe_swap() {
    echo "Wiping swap signature and removing swap partition permanently on $SWAP_DEVICE"
    sudo swapoff $SWAP_DEVICE
    sudo wipefs -a $SWAP_DEVICE
    echo "Removing partition using parted..."
    echo -e "rm 1\nquit" | sudo parted $SWAP_DEVICE
    echo "Swap partition removed permanently."
}

function usage() {
    echo "Usage: $0 {status|disable|enable|wipe}"
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

case "$1" in
    status)
        status_swap
        ;;
    disable)
        disable_swap
        ;;
    enable)
        enable_swap
        ;;
    wipe)
        wipe_swap
        ;;
    *)
        usage
        ;;
esac
