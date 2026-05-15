ARG KEYCLOAK_VERSION=26.5.5
ARG KC_DB=postgres
ARG KC_HTTP_RELATIVE_PATH=/auth
ARG KC_HEALTH_ENABLED=true
ARG KC_METRICS_ENABLED=true

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION} AS builder

ARG KC_DB
ARG KC_HTTP_RELATIVE_PATH
ARG KC_HEALTH_ENABLED
ARG KC_METRICS_ENABLED

ENV KC_DB=${KC_DB}
ENV KC_HTTP_RELATIVE_PATH=${KC_HTTP_RELATIVE_PATH}
ENV KC_HEALTH_ENABLED=${KC_HEALTH_ENABLED}
ENV KC_METRICS_ENABLED=${KC_METRICS_ENABLED}

COPY themes/noir /opt/keycloak/themes/noir
COPY themes/README.md /opt/keycloak/themes/README.md
COPY realm/poc-realm.json /opt/keycloak/data/import/poc-realm.json

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

COPY --from=builder /opt/keycloak/ /opt/keycloak/
