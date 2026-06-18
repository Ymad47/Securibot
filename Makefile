.PHONY: dev deploy clean logs shell-web shell-hermes backup ssl security

dev:
	docker-compose up --build

deploy:
	docker-compose up -d --build

clean:
	docker-compose down -v

logs:
	docker-compose logs -f

shell-web:
	docker-compose exec web /bin/bash

shell-hermes:
	docker-compose exec hermes /bin/bash

shell-db:
	docker-compose exec db psql -U securibot -d securibot

backup:
	docker-compose exec db pg_dump -U securibot securibot > backups/backup_$$(date +%Y%m%d_%H%M%S).sql

ssl:
	docker-compose run --rm certbot certonly \
		--webroot \
		--webroot-path=/var/www/certbot \
		--email admin@ymad.fr \
		--agree-tos \
		--no-eff-email \
		-d securia.ymad.fr

restart:
	docker-compose restart

status:
	docker-compose ps

security:
	@echo "🔒 Running local security scans..."
	@echo ""
	@echo "1/5 Semgrep (Python SAST)..."
	@semgrep --config auto web/ || true
	@echo ""
	@echo "2/5 Bandit (Python security)..."
	@bandit -r web/ || true
	@echo ""
	@echo "3/5 Pip-audit (dependencies)..."
	@pip-audit -r web/requirements.txt || true
	@echo ""
	@echo "4/5 Hadolint (Dockerfile)..."
	@hadolint web/Dockerfile || true
	@echo ""
	@echo "5/5 Gitleaks (secrets)..."
	@gitleaks detect --source . --verbose || true
	@echo ""
	@echo "✅ Security scan complete!"
