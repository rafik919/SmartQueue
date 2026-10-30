@echo off
echo === SmartQueue Backend — Démarrage ===
echo.
echo [1/4] Installation des dépendances...
npm install
echo.
echo [2/4] Démarrage de Docker (Postgres + Redis)...
docker-compose up -d
timeout /t 5 /nobreak > nul
echo.
echo [3/4] Application des migrations...
npx prisma migrate dev --name init
echo.
echo [4/4] Seed des données de test...
npx ts-node prisma/seed.ts
echo.
echo === Backend prêt ! ===
echo API : http://localhost:3000/api/v1
echo Docs : http://localhost:3000/api/docs
echo.
npm run start:dev
