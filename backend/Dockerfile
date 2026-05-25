# syntax=docker/dockerfile:1

# --- deps: install all deps (incl. dev) for the build stage ---
FROM node:24-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci

# --- build: generate Prisma client + compile TypeScript ---
FROM node:24-alpine AS build
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npx prisma generate && npm run build

# --- runtime: production deps only + compiled output ---
FROM node:24-alpine AS runtime
ENV NODE_ENV=production
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev
COPY --from=build /app/dist ./dist
COPY prisma ./prisma
COPY prisma.config.ts ./
EXPOSE 3000
CMD ["node", "dist/server.js"]
