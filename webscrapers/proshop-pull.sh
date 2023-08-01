#!/bin/bash  
   
echo "Kopier dit proshop link her"  
# Take input without defining variable    
read  
# Print the input value
curl -X GET https://n8n-b.rp-helpdesk.com/webhook/proshop-pull-link/?url=$REPLY
