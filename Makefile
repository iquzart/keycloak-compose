# Default settings
KEYCLOAK_VERSION = 26.0.1
SQLSERVER_VERSION = 2019-latest
POSTGRES_VERSION = 15
SA_PASSWORD = P@ssw0rd
PG_USER = keycloak
PG_PASSWORD = keycloak
POSTGRES_DB = keycloak
KC_DB := $(or $(KC_DB), mssql)

# Keycloak DB variables (set directly in the Makefile based on KC_DB)
ifeq ($(KC_DB),mssql)
    KC_DB_URL = jdbc:sqlserver://sqlserver:1433;database=keycloak;trustServerCertificate=false;encrypt=false;
    KC_DB_USERNAME = sa
    KC_DB_PASSWORD = $(SA_PASSWORD)
    TEST_DB_CMD = docker exec sqlserver /opt/mssql-tools18/bin/sqlcmd -C -U sa -P "$(SA_PASSWORD)" -Q "SELECT name FROM sys.databases"
    DOCKER_COMPOSE_FILE = docker-compose.mssql.yml
else ifeq ($(KC_DB),postgres)
    KC_DB_URL = jdbc:postgresql://postgres:5432/keycloak
    KC_DB_USERNAME = $(PG_USER)
    KC_DB_PASSWORD = $(PG_PASSWORD)
    TEST_DB_CMD = docker exec postgres psql -U "$(PG_USER)" -d keycloak -c "\l"
    DOCKER_COMPOSE_FILE = docker-compose.postgres.yml
else
    $(error Unsupported database type: $(KC_DB))
endif

# Export environment variables for Docker Compose
export KEYCLOAK_VERSION
export SQLSERVER_VERSION
export POSTGRES_VERSION
export SA_PASSWORD
export PG_USER
export PG_PASSWORD
export POSTGRES_DB
export KC_DB
export KC_DB_URL
export KC_DB_USERNAME
export KC_DB_PASSWORD

# Bring up the services
up:
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d

# Bring down the services
down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

# Restart the services
restart:
	docker compose -f $(DOCKER_COMPOSE_FILE) restart

# Tail logs
logs:
	docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

# Test the DB connection (MSSQL or PostgreSQL)
test-db:
	$(TEST_DB_CMD)

# Test Keycloak health endpoint
test-keycloak:
	curl -f http://localhost:8081/auth/health/ready || exit 1

# Run all tests
test: test-db test-keycloak
