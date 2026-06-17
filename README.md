# 🔒 SecuriBot AI

**Automated Cybersecurity Audit SaaS — Hermes Agent Hackathon 2026**

[![Hackathon](https://img.shields.io/badge/Hackathon-Nous%20Research%202026-green)](https://discord.gg/nousresearch)
[![Powered by](https://img.shields.io/badge/Powered%20by-Hermes%20Agent-blue)](https://hermes-agent.nousresearch.com)
[![AI](https://img.shields.io/badge/AI-NVIDIA%20Nemotron-orange)](https://build.nvidia.com)

---

## 🎯 Description

SecuriBot est un **SaaS d'audit de cybersécurité 100% automatisé** qui :

1. **Scan** votre infrastructure (Web, Network, SSH)
2. **Analyse** les vulnérabilités avec NVIDIA Nemotron 3 Ultra
3. **Génère** un rapport PDF professionnel
4. **Facture** automatiquement via Stripe

**Stack :** Hermes Agent + FastAPI + HTMX + PostgreSQL + NVIDIA + Stripe

---

## 🚀 Quick Start

### Prérequis

- Docker + Docker Compose
- Domaine configuré (`securia.ymad.fr` → IP VPS)
- Compte Stripe (test mode ok)
- NVIDIA API key (build.nvidia.com)

### Installation

```bash
# 1. Cloner le repo
git clone git@github.com:Ymad47/securibot.git
cd securibot

# 2. Configurer l'environnement
cp .env.example .env
# Éditer .env avec vos clés (Stripe, NVIDIA, DB)

# 3. Obtenir le certificat SSL
make ssl

# 4. Lancer le service
make deploy

# 5. Accéder à l'app
https://securia.ymad.fr
```

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│  CLIENT (Browser)                                           │
│  └── https://securia.ymad.fr                                │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  NGINX + Certbot (Reverse Proxy + HTTPS)                    │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  WEB (FastAPI + HTMX)                                       │
│  ├── Landing page                                           │
│  ├── Dashboard                                              │
│  └── Audit form                                             │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  HERMES AGENT (Worker)                                      │
│  ├── Stripe: Create invoice                                 │
│  ├── Scans: nmap, nikto, ssh-audit                          │
│  ├── NVIDIA Nemotron: Analysis                              │
│  └── Report: PDF generation                                 │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────┐
│  DATABASE (PostgreSQL)                                      │
│  └── Clients, audits, reports                               │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Structure

```
securibot/
├── docker-compose.yml          # Orchestration
├── Makefile                    # Commandes communes
├── .env.example                # Template config
├── web/                        # FastAPI + HTMX
│   ├── Dockerfile
│   ├── main.py
│   ├── requirements.txt
│   └── templates/
│       ├── landing.html
│       ├── dashboard.html
│       └── audit_form.html
├── nginx/                      # Reverse proxy
│   └── nginx.conf
├── hermes/                     # Hermes Agent worker
│   └── skills/
│       ├── securibot-scan/
│       ├── securibot-report/
│       └── securibot-billing/
├── scripts/                    # DB init, backups
└── reports/                    # PDF outputs
```

---

## 💰 Pricing

| Offre | Prix | Description |
|-------|------|-------------|
| **Audit One-Shot** | $499 | Scan complet + rapport PDF |
| **Monitoring** | $299/mois | Scans récurrents + alertes |

---

## 🛠️ Commands

```bash
make dev          # Dev mode (foreground)
make deploy       # Production (background)
make logs         # Voir les logs
make ssl          # Obtenir certificat SSL
make backup       # Backup DB
make clean        # Reset complet
```

---

## 🎬 Démo Vidéo (Hackathon)

**Durée :** 2-3 minutes

**Script :**
1. Landing page → Présentation
2. Submit audit request (exemple.com)
3. Stripe checkout (test mode)
4. Agent lance les scans (terminal output)
5. NVIDIA Nemotron analyse
6. Rapport PDF généré
7. Invoice Stripe envoyée
8. Dashboard mis à jour

---

## 📋 Hackathon Submission

- [x] Tweet avec vidéo démo + @NousResearch
- [ ] Lien dans Discord #submissions
- [ ] Formulaire Typeform

**Deadline :** Mardi 30 Juin, EOD

---

## 🔐 Security Notes

- Ne jamais committer `.env`
- Utiliser Stripe test mode pour dev
- Rotation régulière des API keys
- HTTPS obligatoire en prod

---

## 📄 License

MIT — Hackathon Project 2026

---

**Built with ❤️ by Damy for the Hermes Agent Hackathon**
