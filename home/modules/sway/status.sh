#!/usr/bin/env bash

gpu() {
  GPU="$(nvidia-smi -q | grep "GPU Current Temp" | tr -d "GPU Current Temp:")"
  echo -n "{"
  echo -n \"full_text\": \"GPU: $GPU\",
  echo -n \"color\": \"#124700\",
  echo -n \"align\": \"center\",
  echo -n \"min_width\": \100\,
  echo -n \"urgent\": false
  echo -n "}"
}

cpu() {
  CPU="$(sensors | grep "Tctl" | tr -d "Tctl: +°C")"
  echo -n "{"
  echo -n "full_text":"CPU: $CPU",
  echo -n "color": "#124700",
  echo -n "align": "center"
  echo -n "}"
}

disk() {
  DISK="$(df -h --output=used,size /dev/nvme0n1p1 | tail -n +2 | cut -c 2- | sed 's/  /\//g')"
  echo -n "{"
  echo -n "full_text":"DISK: $DISK",
  echo -n "color": "#124700",
  echo -n "align": "center"
  echo -n "}"
}

ipaddr() {
  IPWORKS="$(ip addr | grep "192.168.*.*")"
  if [[ -n  "$IPWORKS" ]]; then
  IP="$(hostname -I | cut -d' ' -f1)"
  echo -n "{"
  echo -n "full_text":"IP: $IP",
  echo -n "color": "#124700",
  echo -n "align": "center"
  echo -n "}"
else
  echo -n "{"
  echo -n "full_text":"NO CONNECTION",
  echo -n "color": "#124700",
  echo -n "align": "center"
  echo -n "}"
fi
}

internet() {
LAST_RX="$(cat /etc/nixos/home/modules/sway/rx)"
LAST_TX="$(cat /etc/nixos/home/modules/sway/tx)"

CURRENT_RX="$(cat /sys/class/net/enp5s0/statistics/rx_bytes)"
CURRENT_TX="$(cat /sys/class/net/enp5s0/statistics/tx_bytes)"

DIFFERENCE_RX=$((-(LAST_RX-CURRENT_RX)))
DIFFERENCE_TX=$((-(LAST_TX-CURRENT_TX)))

if (( $DIFFERENCE_RX <= 1000 )); then
  RX="$(($DIFFERENCE_RX))B"
elif (( $DIFFERENCE_RX <= 1000*1000 )); then
  RX="$(($DIFFERENCE_RX/1000))KB"
elif (( $DIFFERENCE_RX <= 1000*1000*1000 )); then
  RX="$(($DIFFERENCE_RX/(1000*1000)))MB"
fi

if (( $DIFFERENCE_TX <= 1000 )); then
  TX="$(($DIFFERENCE_TX))B"
elif (( $DIFFERENCE_TX <= 1000*1000 )); then
  TX="$(($DIFFERENCE_TX/1000))KB"
elif (( $DIFFERENCE_TX <= 1000*1000*1000 )); then
  TX="$(($DIFFERENCE_TX/(1000*1000)))MB"
fi

  echo -n "{"
  echo -n "full_text":"UP: $RX | DOWN: $TX",
  echo -n "color": "#124700",
  echo -n "align": "center"
  echo -n "}"

cat /sys/class/net/enp5s0/statistics/rx_bytes > /etc/nixos/home/modules/sway/rx
cat /sys/class/net/enp5s0/statistics/tx_bytes > /etc/nixos/home/modules/sway/tx
}


tzdate() {
  TIME="$(TZ='Europe/Tallinn' date +"%y-%m-%d %H:%M:%S")"
  echo -n "{"
  echo -n "full_text":"TIME: $TIME",
  echo -n "color": "#124700",
  echo -n "align": "center"
  echo -n "}"
}

response() {
echo "{ \"version\": 1, \"click_events\": false }"
echo "["
echo "[]"
while :
do
  echo -n ",["
    gpu
  echo -n "]"
  #  cpu
  #  disk
  #  ipaddr
  #  internet
  #  tzdate
  sleep 5
done
}

response
