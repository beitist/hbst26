FROM nginx:stable-alpine

COPY --chmod=644 nginx.conf /etc/nginx/conf.d/default.conf
# --chmod, weil index.html lokal nur für den Besitzer lesbar ist (600) –
# sonst liefert nginx "403 Forbidden".
COPY --chmod=644 index.html /usr/share/nginx/html/index.html

EXPOSE 80
