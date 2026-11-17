# Termix 26.11.1, official image, pinned by version and multi-arch index digest.
# Upstream: https://github.com/Termix-SSH/Termix/releases/tag/v26.11.1
FROM ghcr.io/termix-ssh/termix:26.11.1@sha256:cac04fdc9cd38c98566e6e903ad77a3a85b62869e6b78ada35e1570cbc32c6cb

# nginx serves the web UI and proxies the backend on $PORT (Railway's public port).
# All state (encrypted SQLite database, generated keys in .env, plugins, uploads)
# lives in /app/data, which the template mounts as a Railway volume.
ENV PORT=8080 \
    DATA_DIR=/app/data

EXPOSE 8080

# The upstream entrypoint fixes volume ownership, renders nginx.conf for $PORT,
# starts nginx and then the Node backend.
CMD ["/entrypoint.sh"]
