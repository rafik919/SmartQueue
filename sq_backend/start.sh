#!/bin/bash
set -e
echo "=== SmartQueue Backend — Démarrage ==="
echo "[1/4] npm install..."
npm install
echo "[2/4] Docker..."
docker-compose up -d
sleep 5
echo "[3/4] Migration..."
npx prisma migrate dev --name init
echo "[4/4] Seed..."
npx ts-node prisma/seed.ts
echo "=== Prêt ! ==="
npm run start:dev
