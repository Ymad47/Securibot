---
name: securibot-scan
description: "Orchestrate cybersecurity scans (nmap, nikto, ssh-audit, sslscan)"
version: 1.0.0
author: Damy (Hermes Hackathon 2026)
---

# SecuriBot Scan Skill

Orchestrates security scanning tools for automated audits.

## Tools Used

- `nmap` - Network port scanning
- `nikto` - Web vulnerability scanner
- `ssh-audit` - SSH configuration checker
- `sslscan` - SSL/TLS analysis

## Usage

Called by Hermes Agent when an audit request is received.

## Workflow

1. Validate target (domain/IP)
2. Run nmap scan
3. Run nikto (if web detected)
4. Run ssh-audit (if SSH detected)
5. Run sslscan (if HTTPS detected)
6. Aggregate results
7. Return to agent for NVIDIA analysis

## Output Format

```json
{
  "target": "example.com",
  "scans": {
    "nmap": {...},
    "nikto": {...},
    "ssh": {...},
    "ssl": {...}
  },
  "timestamp": "2026-06-17T..."
}
```
