#!/bin/bash

# This script sets a timer of 3 mins before telling me to go get my coffee from the coffee machine
# When the timer ends, it curl to a synology chat webhook to send me a message to go get my coffee

# Set the timer
sleep 180

# Send the message to the chat webhook
curl 'https://chat.in-leed.com/webapi/entry.cgi?api=SYNO.Chat.External&method=incoming&version=2&token=%22aqEOk8pMMykRQDVb9CLNZQvBOBBOW3q3RWupYB7juMCK4B4vJbd9my8IceGpQJ40%22' -d 'payload={"text": "@juleshemery, va chercher ton café !"}'

# End of the script
