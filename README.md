# Clavius Tales – Rack starter

Small Ruby/Rack skeleton ready to deploy to Fly.io with Puma.

## Requirements

- Ruby 3.4.7 (via asdf/rbenv is recommended; `.ruby-version` pins it)
- Bundler 2.x (`gem install bundler` after selecting the right Ruby)
- Fly CLI (`brew install flyctl`)

## Run locally

```bash
bundle install
bundle exec rackup -p 3000
# or
bundle exec puma -C config/puma.rb
```

Basic endpoints:
- `GET /` returns a welcome message
- `GET /health` returns a status payload for monitoring

## Testing

```bash
bundle exec rspec
```

Prefer Rake? `bundle exec rake spec`. Tests live under `spec/` and validate the JSON responses with RSpec + Rack::Test.

## Deploy to Fly.io

1. Log in and create the app: `fly auth login && fly launch --no-deploy` (choose name/region).
2. Adjust `fly.toml` as needed (env vars, region, databases, etc.).
3. Set the required secrets: `fly secrets set SOME_KEY=value`.
4. Deploy: `fly deploy`.

### Continuous deploy on GitHub

The workflow at `.github/workflows/deploy.yml` triggers `fly deploy` on every push to `main`.

1. Generate a token: `fly auth token`.
2. In GitHub → **Settings → Secrets and variables → Actions**, add `FLY_API_TOKEN`.
3. Ensure `fly.toml` references the app name that exists in your Fly account.
4. The workflow runs `fly deploy --local-only`, building the image on the GitHub runner (no remote builder). Push to `main` to deploy automatically, or trigger a manual run via _workflow dispatch_.
