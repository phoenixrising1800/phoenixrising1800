#!/bin/bash
# -----------------
# This is a comment. Script to check local ESTABLISHED TCP connections to foreign IP addresses. 
# Uses the Windows Netstat + parses/enriches information

## NEXT TO-DO: Further enrich information with additional data for clarity of where it's coming from.
## E.g. on whatismyipaddress.com the Hostname shows "sockets.betterttv.net" for the OVH Hosting Inc. IP (192.99.44.206), so it's obviouly from one of my Edge browser add-ons.

echo "ESTABLISHED Foreign Addresses not local: "
echo "************************************"
### Get list of IPs, enrich with ipinfo.io information
# -----------------------------------
# 1. Capture output of awk into array into 'my_list` var
mapfile -t my_list < <(netstat.exe -ano | awk '
/ESTABLISHED/ {
  if ($3 !~ /^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[01])\.)/ &&
      $3 !~ /^\[::1/)
    print $3
} 
') # Don't print (local) addresses beginning with '10. | 192.168 | 172. | [::1' etc.

# 2. Iterate through list index + value
#printf '%s\n' "${my_list[@]}"
## --for debugging-- [FYI Nixy the Vim 'visual block' feature is Ctrl-Q in WSL]
#for i in "${!my_list[@]}"; do
#  echo "[$i] = ${my_list[$i]}"
#done

# 3. For each list item, separate out the IP and Port
# Ideally it should look like this:
# FOREIGN IP      PORT
# xxx.xxx.x       443
printf '%-40s %-6s %-8s %-10s %s\n' "FOREIGN IP" "PORT" "COUNTRY" "ASN" "ORG"

# Cache to avoid repeated API calls [thanks ChatGPT]
declare -A cache

for item in "${my_list[@]}"; do
  # IPv4 + IPv6 safe split
  if [[ $item =~ ^\[([^]]+)\]:(.+)$ ]]; then
    ip="${BASH_REMATCH[1]}"
    port="${BASH_REMATCH[2]}"
  else
    ip="${item%:*}"
    port="${item##*:}"
  fi

  # Query API once per IP
  if [[ -z ${cache[$ip]} ]]; then
    cache[$ip]=$(curl -s "https://ipinfo.io/$ip/json")
    sleep 0.5   # be nice to the API
  fi

  json="${cache[$ip]}"

  country=$(jq -r '.country // "N/A"' <<< "$json")
  org=$(jq -r '.org // "N/A"' <<< "$json")
  asn=$(jq -r '.org // "N/A" | split(" ")[0]' <<< "$json")

  printf '%-40s %-6s %-8s %-10s %s\n' \
    "$ip" "$port" "$country" "$asn" "$org"
done
# -----------------------------------
# TO-DO with further enrichment/contextulization of IP sources
