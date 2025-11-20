#!/usr/bin/env bash

gpu() {
  GPU="$(nvidia-smi -q 2>/dev/null | grep "GPU Current Temp" | awk '{print $5}' | head -1)"
  if [[ -z "$GPU" ]]; then
    GPU="N/A"
  fi
  cat <<EOF
{
  "full_text": "GPU: ${GPU}C",
  "color": "#124700",
  "separator": false,
  "separator_block_width": 0
}
EOF
}

cpu() {
  CPU="$(sensors 2>/dev/null | grep "Tctl" | awk '{print $2}' | head -1 | tr -d '+°C')"
  if [[ -z "$CPU" ]]; then
    CPU="$(sensors 2>/dev/null | grep "Package id" | awk '{print $4}' | head -1 | tr -d '+°C')"
  fi
  if [[ -z "$CPU" ]]; then
    CPU="N/A"
  fi
  cat <<EOF
{
  "full_text": "CPU: ${CPU}",
  "color": "#124700", 
  "separator": false,
  "separator_block_width": 0
}
EOF
}

disk() {
  DISK="$(df -h / 2>/dev/null | awk 'NR==2 {print $3 "/" $2}')"
  if [[ -z "$DISK" ]]; then
    DISK="N/A"
  fi
  cat <<EOF
{
  "full_text": "Disk: $DISK",
  "color": "#124700",
  "separator": false,
  "separator_block_width": 0
}
EOF
}

ipaddr() {
  IP="$(ip route get 1 2>/dev/null | awk '{print $7}' | head -1)"
  if [[ -n "$IP" ]]; then
    cat <<EOF
{
  "full_text": "IP: $IP",
  "color": "#124700",
  "separator": false,
  "separator_block_width": 0
}
EOF
  else
    cat <<EOF
{
  "full_text": "NO NET",
  "color": "#FF0000",
  "separator": false, 
  "separator_block_width": 0
}
EOF
  fi
}

internet() {
  LAST_RX_FILE="/tmp/sway_rx"
  LAST_TX_FILE="/tmp/sway_tx"
  
  # Create files if they don't exist
  if [[ ! -f "$LAST_RX_FILE" ]]; then
    echo "0" > "$LAST_RX_FILE"
  fi
  if [[ ! -f "$LAST_TX_FILE" ]]; then
    echo "0" > "$LAST_TX_FILE"
  fi
  
  LAST_RX="$(cat "$LAST_RX_FILE")"
  LAST_TX="$(cat "$LAST_TX_FILE")"
  
  # Try different network interfaces
  for interface in enp5s0 eth0 wlan0; do
    if [[ -d "/sys/class/net/$interface" ]]; then
      CURRENT_RX="$(cat "/sys/class/net/$interface/statistics/rx_bytes" 2>/dev/null || echo "0")"
      CURRENT_TX="$(cat "/sys/class/net/$interface/statistics/tx_bytes" 2>/dev/null || echo "0")"
      break
    fi
  done
  
  if [[ -z "$CURRENT_RX" ]]; then
    CURRENT_RX=0
    CURRENT_TX=0
  fi
  
  DIFF_RX=$((CURRENT_RX - LAST_RX))
  DIFF_TX=$((CURRENT_TX - LAST_TX))
  
  # Convert to human readable
  if [[ $DIFF_RX -lt 1024 ]]; then
    RX="${DIFF_RX}B"
  elif [[ $DIFF_RX -lt 1048576 ]]; then
    RX="$(echo "scale=1; $DIFF_RX/1024" | bc)K"
  else
    RX="$(echo "scale=1; $DIFF_RX/1048576" | bc)M"
  fi
  
  if [[ $DIFF_TX -lt 1024 ]]; then
    TX="${DIFF_TX}B"
  elif [[ $DIFF_TX -lt 1048576 ]]; then
    TX="$(echo "scale=1; $DIFF_TX/1024" | bc)K"
  else
    TX="$(echo "scale=1; $DIFF_TX/1048576" | bc)M"
  fi
  
  echo "$CURRENT_RX" > "$LAST_RX_FILE"
  echo "$CURRENT_TX" > "$LAST_TX_FILE"
  
  cat <<EOF
{
  "full_text": "Net: ↓${RX} ↑${TX}",
  "color": "#124700",
  "separator": false,
  "separator_block_width": 0
}
EOF
}

tzdate() {
  TIME="$(TZ='Europe/Tallinn' date +"%y-%m-%d %H:%M:%S")"
  cat <<EOF
{
  "full_text": "Time: $TIME",
  "color": "#124700",
  "separator": false,
  "separator_block_width": 0
}
EOF
}

# Start the swaybar protocol
echo '{"version": 1, "click_events": true}'
echo '['
echo '[]'

# Main loop
while true; do
  echo -n ",["
  gpu
  echo -n ","
  cpu
  echo -n ","
  disk
  echo -n ","
  ipaddr
  echo -n ","
  internet
  echo -n ","
  tzdate
  echo -n "]"
  sleep 5
done
