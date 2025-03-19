#!/bin/sh

CONFIG_FILE="/etc/chrony/chrony.conf"

if [ -n "$NTP_SERVERS" ]; then
    echo "Generating chrony.conf from NTP_SERVERS environment variable..."
    > "$CONFIG_FILE"
    for server in $NTP_SERVERS; do
        echo "server $server iburst" >> "$CONFIG_FILE"
    done
    cat <<EOF >> "$CONFIG_FILE"
allow 0.0.0.0/0
bindcmdaddress 0.0.0.0
EOF
else
    echo "No NTP_SERVERS defined, using default configuration."
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "server ntp1.aliyun.com iburst" > "$CONFIG_FILE"
        echo "server ntp2.aliyun.com iburst" >> "$CONFIG_FILE"
        echo "server ntp3.aliyun.com iburst" >> "$CONFIG_FILE"
        echo "allow 0.0.0.0/0" >> "$CONFIG_FILE"
        echo "bindcmdaddress 0.0.0.0" >> "$CONFIG_FILE"
    fi
fi

exec chronyd "$@"