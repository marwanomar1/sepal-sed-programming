FROM python:3.11-slim

WORKDIR /mcp_server

RUN pip install uv

COPY pyproject.toml .
COPY src ./src
COPY problems-metadata.json .

# Pre-cache child image base
ARG CACHED_DOCKER_IMAGES="python:3.11-slim"
RUN for img in $CACHED_DOCKER_IMAGES; do docker pull $img || true; done

CMD ["uv", "--offline", "--directory", "/mcp_server", "run", "ctf", "mcp"]
