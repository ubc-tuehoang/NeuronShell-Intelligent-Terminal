#!/bin/bash

MODEL="gpt-4o"

PROMPT="$*"

RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"$MODEL\",
    \"messages\": [{\"role\": \"user\", \"content\": \"provide concise and short answer for the following prompt: $PROMPT\"}]
  }")

# Extract and print response
echo -e "🤖: $(echo "$RESPONSE" | jq -r '.choices[0].message.content')"
