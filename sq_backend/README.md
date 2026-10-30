# SmartQueue — Backend NestJS

## Prérequis
- Node.js 20+
- Docker Desktop
- npm ou pnpm

## Démarrage rapide

### Windows
Double-clique sur `start.bat`

### Mac / Linux
```bash
chmod +x start.sh && ./start.sh
```

### Manuel étape par étape
```bash
# 1. Dépendances
npm install

# 2. Démarrer Postgres + Redis
docker-compose up -d

# 3. Créer .env
cp .env.example .env

# 4. Migration base de données
npx prisma migrate dev --name init

# 5. Seed données de test
npx ts-node prisma/seed.ts

# 6. Lancer le serveur
npm run start:dev
```

## Comptes de test (après seed)
| Rôle   | Email                      | Mot de passe    |
|--------|----------------------------|-----------------|
| Client | demo@smartqueue.app        | Demo@123456     |
| Agent  | agent@bna.dz               | Agent@123456    |
| Admin  | admin@bna.dz               | Admin@123456    |
| Super  | admin@smartqueue.app       | Admin@123456    |

## URLs
- API : http://localhost:3000/api/v1
- Swagger : http://localhost:3000/api/docs
- Prisma Studio : npx prisma studio

## Connecter l'app Flutter
Dans `lib/core/constants/app_constants.dart` :
```dart
// Émulateur Android
static const apiBaseUrl = 'http://10.0.2.2:3000/api/v1';

// Vrai téléphone (même WiFi)
static const apiBaseUrl = 'http://192.168.1.XX:3000/api/v1';
```

Puis dans `lib/core/mock/mock_providers.dart` :
```dart
const bool kMockMode = false; // ← désactiver le mode mock
```
