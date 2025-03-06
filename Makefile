ifneq ("$(wildcard .env-ci)","")
    include .env-ci
    export
endif


up:
	docker compose --env-file .env-ci up -d

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f

test-db:
	docker exec sqlserver /opt/mssql-tools18/bin/sqlcmd -C -U sa -P "$(SA_PASSWORD)" -Q "SELECT name FROM sys.databases"

test-keycloak:
	curl -f http://localhost:8081/auth/health/ready || exit 1

test: test-db test-keycloak


