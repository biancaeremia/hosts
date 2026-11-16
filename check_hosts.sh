#!/bin/bash

verifica_ip() {
    local host="$1"
    local ip="$2"
    local dns_server="$3"

    if nslookup "$host" "$dns_server" 2>/dev/null | awk '/^Address: / { print $2 }' | grep -qx "$ip"; then
        echo "[OK] $host -> $ip (verificat prin DNS $dns_server)"
        return 0
    else
        echo "[EROARE] Bogus IP for $host in /etc/hosts! ($ip, DNS: $dns_server)"
        return 1
    fi
}

DNS="${1:-8.8.8.8}"

while read -r ip host rest; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue

    verifica_ip "$host" "$ip" "$DNS"
done < /etc/hosts
