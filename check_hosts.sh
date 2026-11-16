#!bin/bash

while read -r ip host rest; do
   
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue

   
    if nslookup "$host" 2>/dev/null | grep -q "$ip"; then
        echo "[OK] $host -> $ip este valid"
    else
        echo "[EROARE] Bogus IP for $host in /etc/hosts! ($ip)"
    fi
done < /etc/hosts
EOF
