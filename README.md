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

## Sicherheit und Wartung

Umgesetzt nach `docs/projekt-vorbereiten.md` und `vorlagen/compose.coolify.yaml`
im Repo `server-security-check`:

- Basis-Image exakt gepinnt (`nginx:1.30.6-alpine3.24-slim` im `Dockerfile`).
  Update: Tag ändern, committen, deployen. Ein neuer Tag erzwingt beim Build ein frisches Basis-Image.
- nginx läuft als Benutzer `nginx`, ohne Capabilities, mit schreibgeschütztem Dateisystem
  (nur `/tmp` beschreibbar) und Speicherlimit.
- Das Label `inventar.app=berufsschultag` ordnet den Container im wöchentlichen Inventar zu.
- Das Zugriffsprotokoll enthält keine IP-Adressen und keine Browserkennung.

Kontrolle auf dem Server nach dem Deploy:

```bash
c=$(docker ps -q --filter label=inventar.app=berufsschultag)
docker inspect --format '{{.State.Health.Status}} user={{.Config.User}} ro={{.HostConfig.ReadonlyRootfs}} caps={{.HostConfig.CapDrop}} opts={{.HostConfig.SecurityOpt}} mem={{.HostConfig.Memory}}' $c
docker logs --tail 20 $c
```

Erwartet: `healthy user=nginx ro=true caps=[ALL] opts=[no-new-privileges:true] mem=268435456`
und im Log keine Meldungen mit `Permission denied` oder `Read-only file system`.

## Wichtig

Die Spielstände liegen im Browser der Schüler:innen und hängen an der Domain.
Die Adresse `hbst.kkbkha.de` sollte während der Veranstaltung also nicht wechseln.
