#!/bin/bash
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        ubuntu)
            echo "Ubuntu detected."
            sudo apt update && sudo apt install -y libqmi-utils
            ;;
        fedora)
            echo "Fedora detected."
            sudo yum install -y libqmi-utils
            ;;
	rocky)
	    echo "Rocky Linux detected."
	    sudo yum install -y libqmi-utils
	    ;;
	rhel)
            echo "RHEL detected."
	    sudo yum install -y libqmi-utils
	    ;;
        *)
            echo "Not supported distros: $ID"
            ;;
    esac
else
    echo "Cannot find /etc/os-release. Cannot determine distros"
    exit 1
fi

SOURCE="/usr/share/ModemManager/fcc-unlock.available.d/105b"
TARGET_DIR="/etc/ModemManager/fcc-unlock.d"
TARGET_LINK="$TARGET_DIR/105b:e0ab"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Make directory, $TARGET_DIR"
    sudo mkdir -p "$TARGET_DIR"
fi

echo "Generate link: $TARGET_LINK -> $SOURCE"
sudo ln -sf "$SOURCE" "$TARGET_LINK"

