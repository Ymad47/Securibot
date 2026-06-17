---
name: securibot-report
description: "Generate professional PDF audit reports from scan results"
version: 1.0.0
author: Damy (Hermes Hackathon 2026)
---

# SecuriBot Report Skill

Generates professional PDF reports from security scan results using NVIDIA Nemotron.

## Workflow

1. Receive scan results from securibot-scan
2. Send to NVIDIA Nemotron for analysis
3. Nemotron returns:
   - Risk prioritization (Critical/High/Medium/Low)
   - Detailed findings
   - Recommendations
4. Format as Markdown
5. Convert to PDF (wkhtmltopdf or pandoc)
6. Store in reports/ directory
7. Return path to agent

## Template Structure

```markdown
# Security Audit Report

**Target:** example.com
**Date:** 2026-06-17
**Type:** Standard Audit

## Executive Summary

[Brief overview for non-technical stakeholders]

## Findings

### Critical (N)
- [Finding 1]
- [Finding 2]

### High (N)
...

## Recommendations

[Actionable steps prioritized by impact]

## Technical Details

[Full scan output appendix]
```

## Output

PDF saved to: `reports/{audit_id}_{target}_report.pdf`
