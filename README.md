# Keycloak Spike

This is a starter for a Keycloak server. It uses Docker compose with a custom docker file to run the server inside a container. It assumes there is a Postgres server running outside of the container.

To get an instance of Postgres running quickly and easily, use [postgres_docker](https://github.com/generalui/postgres_docker)

This uses a [quay.io/keycloak/keycloak](https://quay.io/repository/keycloak/keycloak?tab=tags&tag=latest) image.

See <https://www.keycloak.org/server/containers>

## Environment variables

Any environment variables can be set by creating a `.env` file and adding them there. ie:

```.env
KC_DB_PASSWORD=some_password
KC_DB_USERNAME=some_username
```