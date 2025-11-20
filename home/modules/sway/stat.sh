#!/usr/bin/env bash

gpu() {
  GPU="$(nvidia-smi -q | grep "GPU Current Temp" | tr -d "GPU Current Temp:" | xargs)"
  cat <<EOF
{
  "full_text": "GPU: $GPU",
  "color": "#124700",
  "align": "center"
}
EOF
}

cpu() {
  CPU="$(sensors | grep "Tctl" | tr -d "Tctl: +°C" | xargs)"
  cat <<EOF
{
  "full_text": "CPU: $CPU", 
  "color": "#124700",
  "align": "center"
}
EOF
}

disk() {
  DISK="$(df -h --output=used,size /dev/nvme0n1p1 | tail -n +2 | cut -c 2- | sed 's/  /\//g' | xargs)"
  cat <<EOF
{
  "full_text": "DISK: $DISK",
  "color": "#124700",
  "align": "center"
}
EOF
}

ipaddr() {
  IPWORKS="$(ip addr | grep "192.168.*.*")"
  if [[ -n "$IPWORKS" ]]; then
    IP="$(hostname -I | cut -d' ' -f1 | xargs)"
    cat <<EOF
{
  "full_text": "IP: $IP",
  "color": "#124700", 
  "align": "center"
}
EOF
  else
    cat <<EOF
{
  "full_text": "NO CONNECTION",
  "color": "#FF0000",
  "align": "center"
}
EOF
  fi
}

internet() {
  # ... (your existing internet function code)
  cat <<EOF
{
  "full_text": "UP: $RX | DOWN: $TX",
  "color": "#124700",
  "align": "center"
}
EOF
}

tzdate() {
  TIME="$(TZ='Europe/Tallinn' date +"%y-%m-%d %H:%M:%S")"
  cat <<EOF
{
  "full_text": "TIME: $TIME",
  "color": "#124700",
  "align": "center"
}
EOF
}

response() {
  # Send header
  echo '{ "version": 1, "click_events": true }'
  echo '['
  echo '[]'
  
  # Start infinite array
  while true; do
    echo ',['  # New status line
    gpu
    echo ','
    cpu  
    echo ','
    disk
    echo ','
    ipaddr
    echo ','
    internet
    echo ','
    tzdate
    echo ']'
    sleep 5
  done
}

response
