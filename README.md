# Clavius Tales – Rack starter

Pequeno esqueleto em Ruby/Rack pronto para deploy no Fly.io com Puma.

## Pré-requisitos

- Ruby 3.4.7 (recomendado via asdf/rbenv; o arquivo `.ruby-version` ajuda a fixar)
- Bundler 2.x (`gem install bundler` depois de selecionar o Ruby adequado)
- Fly CLI (`brew install flyctl`)

## Como rodar localmente

```bash
bundle install
bundle exec rackup -p 3000
# ou
bundle exec puma -C config/puma.rb
```

Endpoints básicos:
- `GET /` retorna mensagem de boas-vindas
- `GET /health` retorna status para monitoramento

## Deploy no Fly.io

1. Faça login e crie o app: `fly auth login && fly launch --no-deploy` (use o nome/region desejados).
2. Ajuste `fly.toml` conforme necessário (variáveis, região, banco, etc.).
3. Garanta que os segredos foram definidos: `fly secrets set SOME_KEY=valor`.
4. Publique: `fly deploy`.

### Deploy contínuo no GitHub

Há um workflow em `.github/workflows/deploy.yml` que dispara `fly deploy` em todo `push` no branch `main`.

1. Gere um token: `fly auth token`.
2. No repositório GitHub, adicione `FLY_API_TOKEN` em **Settings → Secrets and variables → Actions → New repository secret**.
3. Confirme se `fly.toml` usa o mesmo `app` que existe na sua conta.
4. Ao fazer push na `main`, o GitHub Actions executará o deploy automaticamente. Também é possível iniciar manualmente via _workflow dispatch_.

O arquivo `Procfile` e `fly.toml` já estão configurados para manter uma instância sempre ligada (`min_machines_running = 1`).
