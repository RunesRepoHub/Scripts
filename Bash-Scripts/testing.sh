curl \
  -H "Title: $hostname Now Rebooting" \
  -H "Priority: min" \
  -H "Tags: warning" \
  -d "$hostname has been updated and is now rebooting" \
  https://ntfy.rp-helpdesk.com/Servers