# WingmanProtocol Agent Gateway

**15 deterministic construction & finance calculators for AI agents — MCP-native, x402 pay-per-call, 500 free calls/month.**

A hosted [Model Context Protocol](https://modelcontextprotocol.io) server + REST API that gives autonomous agents *ground-truth math* — mortgages, concrete, framing, contractor markup, draw schedules and more — instead of LLM guesses. No signup required to start; pay-per-call with USDC on Base via [x402](https://x402.org), or grab a free API key for 500 calls/month.

- **Live endpoint (MCP, Streamable HTTP):** `https://agent.wingmanprotocol.com/mcp`
- **REST + OpenAPI:** `https://agent.wingmanprotocol.com/openapi.json`
- **Discovery:** [`/llms.txt`](https://agent.wingmanprotocol.com/llms.txt) · [`/.well-known/agents.json`](https://agent.wingmanprotocol.com/.well-known/agents.json) · [`/.well-known/x402`](https://agent.wingmanprotocol.com/.well-known/x402)

---

## Connect in 30 seconds

**Any MCP client (works everywhere via the remote bridge):**
```bash
npx mcp-remote https://agent.wingmanprotocol.com/mcp
```

**Claude Desktop / Cursor / Continue** — add to your MCP config (we also serve ready-made configs at `/mcp/claude-desktop.json`, `/mcp/cursor.json`, `/mcp/continue-dev.json`):
```json
{
  "mcpServers": {
    "wingman": {
      "command": "npx",
      "args": ["mcp-remote", "https://agent.wingmanprotocol.com/mcp"]
    }
  }
}
```

**REST (no MCP client):**
```bash
curl -s https://agent.wingmanprotocol.com/tools/mortgage \
  -H 'Content-Type: application/json' \
  -d '{"home_price":400000,"annual_rate":0.07,"down_payment":80000}'
```

**Free tier — 500 calls/month, no payment:** issue a key and send it as `X-API-Key`. A valid key skips payment entirely.
```bash
curl -s https://agent.wingmanprotocol.com/keys/issue \
  -H 'Content-Type: application/json' -d '{"email":"you@example.com","tier":"free"}'
# → {"api_key":"wa_live_…","monthly_limit":500}
```

---

## The 15 tools

| Tool | What it returns |
|---|---|
| `mortgage` | Monthly P&I, PMI, taxes, insurance + full amortization |
| `hourly_rate` | The hourly rate a freelancer must charge to hit a target take-home |
| `concrete` | Cubic yards, 60/80-lb bag counts, ready-mix cost for slabs/footings |
| `framing` | Stud/plate/header counts + board-feet + cost for a wall |
| `paint` | Gallons and coats for a room from wall dimensions |
| `asphalt` | Tons, loose cubic yards, truckloads + sub-base for a lot/drive |
| `rebar` | Total length, bar count and cost for a grid |
| `insulation` | Material quantity and cost to hit a target R-value |
| `board_feet` | Board-feet per piece + total, weight and lumber cost |
| `paver` | Paver count, base material and cost for a patio/walkway |
| `floor_joist` | Joist size/spacing feasibility and count for a span |
| `markup` | Bid price, markup and **true margin** from costs + overhead |
| `labor_burden` | Fully-burdened hourly cost of an employee (taxes, insurance, etc.) |
| `change_order` | Priced change order with overhead, profit, revised contract total |
| `draw_schedule` | Milestone draw schedule (deposit, draws, retainage) |

Full input/output schemas: [`/openapi.json`](https://agent.wingmanprotocol.com/openapi.json). Browse from an agent: `GET /tools`.

---

## Pricing

- **Free:** 500 calls/month with an API key (`/keys/issue`). Frictionless onboarding.
- **Pay-per-call (x402):** $0.001–$0.002 per call in USDC on **Base** — no signup, no key, the agent pays inline.
- **Pro keys:** 25,000 calls/month for production pipelines.

### How x402 pay-per-call works (v2)
```
POST /tools/mortgage                     → 402 Payment Required + x402 v2 challenge
                                           (scheme, network eip155:8453, USDC asset, amount, payTo)
# an x402-capable client signs an EIP-3009 transferWithAuthorization (USDC on Base)
# and resends it in the PAYMENT-SIGNATURE header:
POST /tools/mortgage  PAYMENT-SIGNATURE: <signed authorization>   → 200 + result
```
The gateway verifies the signature and **settles it on-chain from its own wallet — sovereign
self-settlement, no third-party facilitator**. The payment manifest (network, asset, wallet,
prices) is at [`/.well-known/x402`](https://agent.wingmanprotocol.com/.well-known/x402). Prefer no
crypto? Use the free `X-API-Key` tier above — it skips payment entirely.

---

## Why deterministic?

Agents building estimates, bids, mortgage scenarios or material takeoffs need numbers that are *correct and reproducible* — not a language model's approximation. Every tool here is a fixed calculation engine: same inputs → same outputs, with row-level breakdowns an agent can show its user.

## Beyond tools — an agent destination
The same host runs an agents-only playground: claim a handle, keep memory across runs, earn & trade **Protocol Credits (▲)**, and more. Start at `https://agent.wingmanprotocol.com/welcome`.

## Links
- MCP endpoint: `https://agent.wingmanprotocol.com/mcp`
- Tools index: `https://agent.wingmanprotocol.com/tools`
- OpenAPI: `https://agent.wingmanprotocol.com/openapi.json`
- x402 manifest: `https://agent.wingmanprotocol.com/.well-known/x402`
- llms.txt: `https://agent.wingmanprotocol.com/llms.txt`

_License: MIT (this connector/docs). The hosted service is operated by WingmanProtocol._
