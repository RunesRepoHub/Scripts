#!/bin/bash

# Collect CPU usage
cpu_usage=$(top -bn 1 | grep '%Cpu' | awk '{print $2}')

# Collect CPU information
cpu=$(lscpu | awk '/^CPU\(s\)/ {print $2}')
total_cpu=$(lscpu | awk '/^Socket\(s\)/ {print $2}')

# Collect RAM usage
ram_usage=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')

# Collect RAM information
total_ram=$(free -m | awk '/^Mem:/{print $2}')
free_ram=$(free -m | awk '/^Mem:/{print $4}')

# Collect disk usage
disk_usage=$(df -h | awk '$NF=="/"{printf "%.2f", $5}')

# Collect disk information
disk_total=$(df -h | awk '$NF=="/"{print $2}')
disk_free=$(df -h | awk '$NF=="/"{print $4}')

# Send data to Node.js server
curl -X POST -H "Content-Type: application/json" -d '{
  "cpu_usage": "'"$cpu_usage"'",
  "cpu": "'"$cpu"'",
  "total_cpu": "'"$total_cpu"'",
  "ram_usage": "'"$ram_usage"'",
  "total_ram": "'"$total_ram"'",
  "free_ram": "'"$free_ram"'",
  "disk_usage": "'"$disk_usage"'",
  "disk_total": "'"$disk_total"'",
  "disk_free": "'"$disk_free"'"
}' http://your-nodejs-server-url:3001/usage
