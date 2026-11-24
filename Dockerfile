# Basis exakt gepinnt (nginx-Version + Alpine-Release), wie in
# docs/projekt-vorbereiten.md im Repo server-security-check vorgegeben.
# Variante "-slim": nur nginx und das Alpine-Grundsystem (21 Pakete) statt
# 71 Paketen mit curl, njs, Bildbibliotheken usw., die hier niemand braucht.
# Update: Tag ändern, committen, deployen. Aktuelle Tags:
# https://hub.docker.com/_/nginx/tags?name=alpine3.24-slim
FROM nginx:1.31.10-alpine3.24-slim

# Vollständige Konfiguration für den Betrieb ohne root (Erklärung in nginx.conf).
# Den Server-Block aus dem Image braucht es dann nicht mehr.
COPY --chmod=644 nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

# --chmod, weil index.html lokal nur für den Besitzer lesbar ist (600) –
# sonst liefert nginx "403 Forbidden".
COPY --chmod=644 index.html /usr/share/nginx/html/index.html

# Benutzer aus dem Basis-Image (UID 101), nicht root.
USER nginx

EXPOSE 80
