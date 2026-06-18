# 🔒 Security Workflow Template

Reusable GitHub Actions workflow for security scanning across all projects.

## 📋 Features

| Scan | Tool | Detects |
|---|---|---|
| **SAST** | Semgrep + Bandit | Python vulnerabilities, code smells |
| **Dependencies** | pip-audit | Known CVEs in requirements.txt |
| **Docker** | Hadolint + Trivy | Dockerfile best practices, image vulns |
| **Secrets** | Gitleaks | API keys, passwords in git history |
| **IaC** | Checkov | Misconfigurations in docker-compose, K8s |

## 🚀 Setup

### 1. Add workflow to your project

```bash
mkdir -p .github/workflows
cp /path/to/security.yml .github/workflows/
```

### 2. Adjust paths in workflow

Edit `.github/workflows/security.yml`:

```yaml
# Update these for your project:
- Dockerfile path: web/Dockerfile → your/Dockerfile
- Requirements: web/requirements.txt → your/requirements.txt
- Python version: 3.11 → your version
- DEFAULT_BRANCH: main → your branch
```

### 3. Install tools locally (optional)

```bash
# Python tools
pip install semgrep bandit pip-audit checkov

# System tools
sudo apt install -y gitleaks hadolint
```

### 4. Add Make target (optional)

Add to your `Makefile`:

```makefile
.PHONY: security

security:
	@echo "🔒 Running security scans..."
	@semgrep --config auto . || true
	@bandit -r . || true
	@pip-audit -r requirements.txt || true
	@hadolint Dockerfile || true
	@gitleaks detect --source . --verbose || true
	@echo "✅ Security scan complete!"
```

## 📊 GitHub Security Tab

Results automatically appear in:
- **Security → Code scanning alerts** (Semgrep, Trivy, Checkov)
- **Secret scanning** (Gitleaks)

## 🔑 Secrets (optional)

For Gitleaks Pro (faster, more features):

```bash
# Get free license for open source
# https://github.com/marketplace/gitleaks-action

# Add to GitHub Secrets:
GITLEAKS_LICENSE=your_license_key
```

## 🎯 Example Projects

### FastAPI / Python

```yaml
# Already configured ✅
```

### Node.js / TypeScript

```yaml
# Add these steps:
- name: npm audit
  run: npm audit --audit-level=high

- name: ESLint security
  uses: returntocorp/semgrep-action@v1
  with:
    config: p/javascript
```

### Go

```yaml
# Add these steps:
- name: GolangCI-Lint
  uses: golangci/golangci-lint-action@v3

- name: Govulncheck
  run: go install golang.org/x/vuln/cmd/govulncheck@latest && govulncheck ./...
```

## 📝 Notes

- `if: always()` ensures all scans run even if one fails
- `soft_fail: true` prevents workflow from blocking on Checkov
- Adjust `severity` filters based on your tolerance
- Run locally with `make security` before pushing

---

**Template by:** Damy for SecuriBot (Hermes Hackathon 2026)
**License:** MIT — Reuse across all your projects!
