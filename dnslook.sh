#!/usr/bin/env bash

IPS=("66.249.66.246" "66.249.66.97" "66.249.64.12")
WHITEBOTS=("googlebot.com" ".crawl.baidu.com" ".crawl.baidu.jp" ".search.msn.com" ".google.com" ".googlebot.com" ".crawl.yahoo.net" ".yandex.ru" ".yandex.net" ".yandex.com")


get_os_release() {
  if [[ -f /etc/os-release ]]; then
    cat /etc/os-release | grep 'ID_LIKE' | cut -d'=' -f2
  else
    echo "unknown"
  fi
}


valid_cmd() {
  command -v $1 >/dev/null 2>&1
}


lookup() {
  for ip in "${IPS[@]}"
    do
      # IP Reverse DNS lookup
      hostname=$(host ${ip} | cut -d" " -f 5)
      dns=$(echo "${hostname}" | cut -d"." -f 2,3)
      # Forward DNS lookup
      forwarded_ip=$(host "${hostname}" | cut -d" " -f 4)

      echo "[INFO] Hostname: ${hostname}"
      echo "[INFO] Domain name: ${dns}"

      if [[ "${ip}" == "${forwarded_ip}" ]]; then
        echo "[OK] Identifiers correct match."
      else
        echo "[CAUTION] Something isn't cool! :S"
      fi
  done
}


while [[ $# -gt 0 ]]
  do
    case "${1}" in
      --start)
            lookup
          break
          shift;;
    esac
  shift
done
