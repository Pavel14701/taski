# Этап 1: сборка React-фронтенда
FROM node:16.20-alpine AS frontend

WORKDIR /app
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY frontend/ .
RUN npm run build

# Этап 2: nginx
FROM nginx:1.27-alpine

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY nginx/entrypoint.sh /entrypoint.sh
COPY --from=frontend /app/build /usr/share/nginx/html

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
