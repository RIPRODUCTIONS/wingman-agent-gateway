# Do not publish `server.json` from this directory

`server.json` here is a stale **v1.3.0** copy that declares the MCP namespace
`com.wingmanprotocol/agent-gateway`.

The publishing token grants `com.wingmanprotocol.agent/*`, so this name is **out of
scope**. Publishing this file would not update the existing registry entry — it would
attempt to mint a **second, unrelated** entry that cannot be withdrawn afterwards.

**The real publish artifact is:**

    /opt/sovereign/revenue/agent_gateway/server.registry.json

which is live in the Official MCP Registry at **v1.6.0** (published 2026-09-11,
`isLatest` confirmed) under the correct name `com.wingmanprotocol.agent/gateway`.

Procedure and auth steps: `revenue/agent_gateway/DISTRIBUTION.md`, "Registry / index
presence", item 1.

This directory is kept only as a historical checkout. Prefer the `/opt/sovereign`
canonical tree.

— 2026-09-12
