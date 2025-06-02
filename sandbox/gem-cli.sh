#!/bin/bash

MODEL="gemini-2.0-flash-lite"
PROMPT="$*"

# Escape the prompt for JSON
ESCAPED_PROMPT=$(printf '%s' "provide concise and short answer for the following prompt: $PROMPT" | jq -Rsa .)

RESPONSE=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent?key=$GEM_API_KEY" \
  -H 'Content-Type: application/json' \
  -X POST \
  -d "{
    \"contents\": [
      {
        \"parts\": [
          {
            \"text\": ${ESCAPED_PROMPT}
          }
        ]
      }
    ]
  }")

# Extract and print response
echo -e "💎: $(echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text')"
