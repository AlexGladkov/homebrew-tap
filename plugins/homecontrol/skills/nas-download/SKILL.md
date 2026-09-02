---
name: nas-download
description: Download a movie, series, or music onto the home NAS — never avi, default 1080p, Russian dub preferred. Checks NAS free space first (refuses + lists what to delete if short, never deletes on its own), adds to qBittorrent, shows progress, and auto-imports into Jellyfin. Music routes through Soulseek. Use when the user says "скачай фильм/сериал/музыку", "download <movie/show>", "/nas-download", or wants something added to the NAS media library.
---

# nas-download

Acquires media onto the NAS with the pick policy (non-avi, 1080p default, Russian-preferred),
a free-space guard, progress, and auto-import. Helper: `bin/nas-download.sh` (installed as
`nas-download` on PATH).

## Flow

1. **Plan first (safe, no download):**
   ```bash
   nas-download plan "The Bear season 3" --type series
   ```
   Prints the chosen release (seeders, size, indexer) and the space verdict.

2. **If it reports INSUFFICIENT SPACE** — relay the deficit + the deletable candidates
   (torrents with hashes, big media dirs) to the user. Do NOT delete anything yourself.
   After they choose something to free, either they delete it or re-run `get --free <hash>`.

3. **If it reports ⚠ AVI-ONLY** — tell the user only an avi release exists; offer
   `--transcode-avi` (downloads it and transcodes to MP4). Don't grab avi silently.

4. **Download + import:**
   ```bash
   nas-download get "The Bear season 3" --type series
   ```
   Adds to qBittorrent (force-started), prints initial progress, then auto-imports into the
   Jellyfin library on completion.

5. **Progress of active downloads:**
   ```bash
   nas-download status
   ```

## Options

| Option | Meaning |
|---|---|
| `--type movie\|series\|music` | media type (auto-detected from the query if omitted) |
| `--quality 1080p\|2160p\|720p` | default `1080p` |
| `--transcode-avi` | opt-in to download an avi-only result and transcode to MP4 |
| `--free <hash>` | free the given torrent then proceed (space case) |

## Notes

- Requires the NAS credential in the keychain (`nas-connect setup` if missing).
- Never deletes to make room — it lists candidates and the user decides.
- Music goes through Soulseek (slskd), not torrents.
- Do NOT print the sudo password; it is read from the keychain and piped over ssh stdin.
