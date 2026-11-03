# Talent-Mission · Hagener Berufsschultag

Die App ist eine einzelne Datei (`index.html`). Der Container liefert sie über nginx aus,
HTTPS und Domain übernimmt Coolify.

## Deployment in Coolify

1. Diesen Ordner in ein Git-Repository pushen (GitHub, GitLab, Gitea – privat ist okay).
2. In Coolify: Projekt öffnen → **+ New** → **Resource** → passende Repository-Variante wählen
   (öffentlich, GitHub App oder Deploy Key).
3. **Build Pack:** `Docker Compose`
   - Base Directory: `/`
   - Docker Compose Location: `/docker-compose.yml`
4. Beim Service **web** unter **Domains** eintragen: `https://hbst.kkbkha.de`
5. **Deploy** klicken. Das SSL-Zertifikat holt Coolify automatisch.

## App aktualisieren

`index.html` ersetzen → committen und pushen → in Coolify **Redeploy**
(oder automatisch, falls Webhook/GitHub App eingerichtet ist).

Der Browser fragt bei jedem Aufruf nach einer neuen Version – Änderungen sind also sofort sichtbar.

## Wichtig

Die Spielstände liegen im Browser der Schüler:innen und hängen an der Domain.
Die Adresse `hbst.kkbkha.de` sollte während der Veranstaltung also nicht wechseln.
