# Keycloak Setup for Local Development

[![Keycloak Database Integration Tests](https://github.com/iquzart/keycloak-compose/actions/workflows/ci-dbs.yml/badge.svg)](https://github.com/iquzart/keycloak-compose/actions/workflows/ci-dbs.yml)

This repository provides a Docker-based setup for Keycloak, with support for both SQL Server (MSSQL) and PostgreSQL as databases. It is designed for local development, testing, and experimentation with Keycloak, and is useful for testing Single Sign-On (SSO) applications.

## Prerequisites

Before using this repository, ensure you have the following installed:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Make**: (Optional) Most Unix-based systems have `make` pre-installed. For Windows, you can use [WSL](https://docs.microsoft.com/en-us/windows/wsl/install) or a tool like [Chocolatey](https://chocolatey.org/).

## Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/iquzart/keycloak-compose.git
   cd keycloak-compose
   ```

2. Configure the database type:

   - By default, the `Makefile` uses **Microsoft SQL Server** (`mssql`).
   - To switch to **PostgreSQL**, set the `KC_DB` environment variable:
     ```bash
     export KC_DB=postgres
     ```

3. Start the services:

   ```bash
   make up
   ```

   This will start the following services:

   - **Keycloak**: Running on port `8080`.
   - **Database**: Either Microsoft SQL Server or PostgreSQL, depending on the `KC_DB` setting.

## Makefile Commands

The `Makefile` provides several commands to manage the services and run tests:

| Command              | Description                                                 |
| -------------------- | ----------------------------------------------------------- |
| `make up`            | Starts the Keycloak and database services in detached mode. |
| `make down`          | Stops and removes the running services.                     |
| `make restart`       | Restarts the services.                                      |
| `make logs`          | Tails the logs of the running services.                     |
| `make test-db`       | Tests the connection to the database (MSSQL or PostgreSQL). |
| `make test-keycloak` | Tests the Keycloak health endpoint to ensure it's ready.    |
| `make test`          | Runs all tests (`test-db` and `test-keycloak`).             |

## Configuration

### Environment Variables

You can customize the setup by overriding the following environment variables:

| Variable            | Default Value | Description                                       |
| ------------------- | ------------- | ------------------------------------------------- |
| `KEYCLOAK_VERSION`  | `26.0.1`      | The version of Keycloak to use.                   |
| `SQLSERVER_VERSION` | `2019-latest` | The version of Microsoft SQL Server to use.       |
| `POSTGRES_VERSION`  | `15`          | The version of PostgreSQL to use.                 |
| `SA_PASSWORD`       | `P@ssw0rd`    | The password for the SQL Server `sa` user.        |
| `PG_USER`           | `keycloak`    | The username for the PostgreSQL database.         |
| `PG_PASSWORD`       | `keycloak`    | The password for the PostgreSQL user.             |
| `POSTGRES_DB`       | `keycloak`    | The name of the PostgreSQL database.              |
| `KC_DB`             | `mssql`       | The database type to use (`mssql` or `postgres`). |

### Example: Switching to PostgreSQL

To switch to PostgreSQL, set the `KC_DB` variable before running `make up`:

```bash
export KC_DB=postgres
make up
```

### Example: Testing the Setup

After starting the services, you can run the tests to ensure everything is working:

```bash
make test
```

This will:

1. Test the database connection.
2. Check the Keycloak health endpoint.

## Compose Files

The repository includes two Compose files:

- `compose.mssql.yml`: For Microsoft SQL Server.
- `compose.postgres.yml`: For PostgreSQL.

The appropriate file is selected based on the `KC_DB` variable.

## Troubleshooting

- **Keycloak not starting**: Ensure the database is running and accessible. Check the logs using `make logs`.
- **Database connection issues**: Verify the database credentials and ensure the database service is running.
