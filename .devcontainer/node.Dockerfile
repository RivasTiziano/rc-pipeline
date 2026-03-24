# Etapa de dependencias
FROM node:20-alpine AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Etapa de build
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npx nx build frontend --prod

# Etapa final (Producción - Imagen liviana)
FROM nginx:alpine AS runner
COPY --from=builder /app/dist/apps/frontend /usr/share/nginx/html