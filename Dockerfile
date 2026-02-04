# ---------- Build stage ----------
FROM gcc:13 AS builder

WORKDIR /build

# Install build tools
RUN apt-get update && apt-get install -y \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy source
COPY CMakeLists.txt .
COPY src ./src
COPY problems-metadata.json .

# Build
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
 && cmake --build build --target mcp_server

# ---------- Runtime stage ----------
FROM debian:bookworm-slim

WORKDIR /mcp_server

# Minimal runtime deps
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Copy binary + metadata
COPY --from=builder /build/build/mcp_server /usr/local/bin/mcp_server
COPY problems-metadata.json .

# Run C++ MCP/CTF service
CMD ["mcp_server"]
