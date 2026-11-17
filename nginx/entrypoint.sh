#!/bin/sh
# Ждём, пока backend выполнит collectstatic в общий volume,
# затем подкладываем статику Django рядом со статикой React.
i=0
while [ $i -lt 120 ]; do
    if [ -d /django_static/admin ]; then
        break
    fi
    i=$((i + 1))
    sleep 1
done

mkdir -p /usr/share/nginx/html/static
cp -r /django_static/. /usr/share/nginx/html/static/ 2>/dev/null || true

exec nginx -g 'daemon off;'
