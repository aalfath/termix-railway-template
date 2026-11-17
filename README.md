[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/termix-1?utm_medium=integration&utm_source=button&utm_campaign=termix)

# Termix on Railway

A one-service [Railway](https://railway.com) template for [Termix](https://termix.site), the self-hosted, plugin-based server manager (web SSH terminal, SSH tunnels, remote file manager, server stats and remote desktop).

## What it deploys

| Service | Source | Version | Storage |
|---|---|---|---|
| `Termix` | this repo's `Dockerfile` | Termix **26.11.1** (`ghcr.io/termix-ssh/termix:26.11.1@sha256:cac04fdc…c6cb`) | volume on `/app/data` |

- Public HTTPS domain on port 8080, health check `GET /health`.
- Termix keeps everything in `/app/data`: its encrypted SQLite database, the keys it generates on first boot (`/app/data/.env`), plugins and uploads. The volume keeps them across redeploys and updates.
- No default account and no default password. **The first account you create becomes the admin.** Open your domain right after the deploy, create it, then turn off sign-ups in the admin settings if you don't want other people to register.

## Variables

| Variable | Default | Why |
|---|---|---|
| `PORT` | `8080` | Port nginx listens on; the Railway domain targets it |

Everything else uses Termix's defaults. Optional settings (OIDC/LDAP via the SSO plugin, `TRUSTED_PROXIES`, `ALLOW_REGISTRATION`, `LOG_LEVEL`, an external Postgres or MySQL with `DATABASE_DIALECT` and `DATABASE_URL`) are listed in the upstream [environment catalog](https://github.com/Termix-SSH/Termix/blob/main/env.catalog.json). Add them on the service if you need them.

## Updates

The service builds from this repo's `main` branch. When a new Termix release is pinned here, Railway shows deployers an "update available" notice, and you choose when to apply it. Read [`CHANGELOG.md`](CHANGELOG.md) first: breaking changes are listed at the top of each entry. Termix backs up its data folder before a database upgrade.

## Run it locally

```sh
docker build -t termix-railway .
docker run -p 8080:8080 -v termix-data:/app/data termix-railway
```

Termix is Apache-2.0 licensed by its authors. This repo only packages it for Railway.
