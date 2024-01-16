# Add cronjobs for turning off VM 9001
echo "0 0 * * 1-5 root qm stop 9001" | sudo tee -a /etc/crontab >/dev/null
echo "0 2 * * 6-7 root qm stop 9001" | sudo tee -a /etc/crontab >/dev/null

# Add cronjobs for turning on VM 9001
echo "0 14 * * 1-5 root qm start 9001" | sudo tee -a /etc/crontab >/dev/null
echo "0 10 * * 6-7 root qm start 9001" | sudo tee -a /etc/crontab >/dev/null
