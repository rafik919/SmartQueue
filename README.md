# SmartQueue

Plateforme de gestion de files d’attente, conçue pour les organisations et leurs usagers. Le dépôt regroupe l’API, les portails web et l’application mobile.

## Applications

| Dossier | Technologie | Rôle |
| --- | --- | --- |
| `sq_backend` | NestJS, Prisma, PostgreSQL, Redis | API, temps réel et administration des données |
| `sq_dashboard_v2` | Next.js | Tableau de bord d’administration |
| `sq_agent` | Next.js | Interface opérationnelle des agents |
| `sq_mobile_new` | Flutter | Application mobile des usagers |

## Prérequis

- Node.js 20 ou ultérieur et npm
- Flutter 3.19 ou ultérieur
- Docker Desktop (PostgreSQL et Redis pour l’API)

## Démarrage local

1. Préparez l’API :

   ```bash
   cd sq_backend
   cp .env.example .env
   npm ci
   docker compose up -d
   npx prisma migrate dev
   npm run prisma:seed
   npm run start:dev
   ```

2. Dans un autre terminal, lancez les portails web :

   ```bash
   cd sq_dashboard_v2 && npm ci && npm run dev
   # ou
   cd sq_agent && npm ci && npm run dev
   ```

3. Lancez l’application mobile :

   ```bash
   cd sq_mobile_new
   flutter pub get
   flutter run
   ```

Consultez les README de chaque application pour les détails propres à leur environnement.

## Qualité

Avant une contribution, exécutez les contrôles adaptés au composant modifié :

```bash
# API
cd sq_backend && npm run lint && npm run build

# Portail web
cd sq_dashboard_v2 && npm run lint && npm run build

# Mobile
cd sq_mobile_new && flutter analyze && flutter test
```

## Sécurité

Ne publiez jamais de fichier `.env`, clé privée, jeton ou identifiant de production. Utilisez les fichiers `*.example` pour documenter les variables nécessaires. Pour signaler une vulnérabilité, consultez [SECURITY.md](SECURITY.md).

## Licence

Tous droits réservés, sauf accord écrit contraire des détenteurs du projet.
