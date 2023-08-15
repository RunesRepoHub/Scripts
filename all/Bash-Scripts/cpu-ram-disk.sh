#!/bin/bash
# This script monitors CPU and memory usage
  IP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
  hostname="$(hostname)"
  # Get the current usage of CPU and memory
  DISK_SIZE_TOTAL=$(df -kh . | tail -n1 | awk '{print $2}')
  DISK_SIZE_FREE=$(df -kh . | tail -n1 | awk '{print $4}')
  DISK_PERCENT_USED=$(df -kh . | tail -n1 | awk '{print $5}')
  cpuUsage=$(top -bn1 | awk '/Cpu/ { print $2}')
  memTotal=$(free -m | awk '/Mem/{print $2}')
  memFree=$(free -m | awk '/Mem/{print $4}')
  memUsed=$(free -m | awk '/Mem/{print $3}')
  hddUsage=$"(${DISK_SIZE_FREE} available out of ${DISK_SIZE_TOTAL} total (${DISK_PERCENT_USED} used).)"
  memUsage=$(awk "BEGIN { printf ($memUsed/$memTotal*100) }")
 
  curl -s "https://n8n-b.rp-helpdesk.com/webhook/5b1828eb-bcb4-457a-b1bf-6451e929fe56?CPU=$cpuUsage&memUsage=$memUsage&memUsed=$memUsed&memTotal=$memTotal&memFree=$memFree&DISK_SIZE_FREE=$DISK_SIZE_FREE&DISK_SIZE_TOTAL=$DISK_SIZE_TOTAL&DISK_PERCENT_USED=$DISK_PERCENT_USED&hostname=$hostname&IP=$IP"
