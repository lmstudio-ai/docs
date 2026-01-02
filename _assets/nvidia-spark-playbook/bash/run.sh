# Send request to LM Studio v1 REST API

#!/bin/bash

PROMPT="List three cool project ideas that I can run with a local LLM"

echo "Sending prompt: $PROMPT"
echo ""
echo "Response:"

# Replace {SPARK_LOCAL_IP} with the IP address of your DGX Spark on your local network
curl -s -N http://{SPARK_LOCAL_IP}:1234/api/v1/chat \
 -H "Content-Type: application/json" \
 -d "{
   \"model\": \"openai/gpt-oss-120b\",
   \"input\": \"$PROMPT\",
   \"stream\": true
 }" | while IFS= read -r line; do
   line=$(echo "$line" | sed 's/^data: //')
   content=$(echo "$line" | jq -r 'select(.type == "message.delta") | .content' 2>/dev/null)
   if [[ -n "$content" && "$content" != "null" ]]; then
     printf '%s' "$content"
   fi
 done

echo ""
echo ""
echo "Done!"




# Alternative: Send request to OpenAI-compatible REST API

#!/bin/bash

PROMPT="List three cool project ideas that I can run with a local LLM"

echo "Sending prompt: $PROMPT"
echo ""
echo "Response:"

# Replace {SPARK_LOCAL_IP} with the IP address of your DGX Spark on your local network
curl -s -N http://{SPARK_LOCAL_IP}:1234/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"openai/gpt-oss-120b\",
    \"messages\": [
      {
        \"role\": \"user\",
        \"content\": \"$PROMPT\"
      }
    ],
    \"stream\": true
  }" | while IFS= read -r line; do
    if [[ "$line" =~ ^data:\ (.*)$ ]]; then
      printf '%s' "${BASH_REMATCH[1]}" | jq -j '.choices[0].delta | .reasoning // empty, .content // empty' 2>/dev/null || true
    fi
  done

echo ""
echo ""
echo "Done!"