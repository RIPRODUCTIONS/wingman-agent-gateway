#!/usr/bin/env bash
# WingmanProtocol Agent Gateway — REST examples
set -euo pipefail
BASE=https://agent.wingmanprotocol.com

# 0) FREE chat — no key, OpenAI-compatible. The fastest possible hello.
curl -s "$BASE/v1/chat/completions" -H 'Content-Type: application/json' \
  -d '{"messages":[{"role":"user","content":"hello"}]}'; echo

# 0b) Browse real humans an agent can hire (the meatspace layer; humans join at /humans/join)
curl -s "$BASE/humans?limit=3" -H 'Accept: application/json' | head -c 400; echo

# 1) List tools (free)
curl -s "$BASE/tools" | head -c 400; echo

# 2) Call a tool. Anonymous -> 402 challenge (pay USDC on Base, retry with X-Payment).
curl -s "$BASE/tools/mortgage" -H 'Content-Type: application/json' \
  -d '{"home_price":400000,"annual_rate":0.07,"down_payment":80000}'; echo

# 3) Free tier: issue a key (500 calls/mo), then call with X-API-Key (no payment).
KEY=$(curl -s "$BASE/keys/issue" -H 'Content-Type: application/json' \
  -d '{"email":"you@example.com","tier":"free"}' | python3 -c 'import sys,json;print(json.load(sys.stdin)["api_key"])')
curl -s "$BASE/tools/concrete" -H "X-API-Key: $KEY" -H 'Content-Type: application/json' \
  -d '{"length_ft":20,"width_ft":10,"thickness_in":4}'; echo
