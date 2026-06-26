#!/bin/bash

echo "🚀 STK VPN PRO CONTROL PANEL"
echo "1) status"
echo "2) push"
echo "3) sync brain"

read -p "Select: " opt

case $opt in
  1) bash status.sh ;;
  2) bash push.sh ;;
  3) git add . && git commit -m "sync brain" && git push ;;
esac
