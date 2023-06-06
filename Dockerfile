ARG keycloakVersion

FROM quay.io/keycloak/keycloak:${keycloakVersion} as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=${KC_HEALTH_ENABLED:-true}
ENV KC_METRICS_ENABLED=${KC_METRICS_ENABLED:-true}
# Configure a database vendor
ENV KC_DB=${KC_DB:-postgres}

WORKDIR /opt/keycloak

# for demonstration purposes only, please make sure to use proper certificates in production instead
# RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:${keycloakVersion}

COPY --from=builder /opt/keycloak/ /opt/keycloak/

# change these values to point to a running postgres instance
ENV KC_DB=${KC_DB:-postgres}
ENV KC_HOSTNAME=${KC_HOSTNAME:-localhost}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD:-docker}
ENV KC_DB_URL=${KC_DB_URL:-jdbc:postgresql://${KC_DB_URL_HOST:-host.docker.internal}/${KC_DB_NAME:-keycloak_spike}}
ENV KC_DB_USERNAME=${KC_DB_USERNAME:-postgres}
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]