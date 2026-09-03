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

4. **Download:**
   ```bash
   nas-download get "The Bear season 3" --type series
   ```
   Adds to qBittorrent (force-started) and prints initial progress. `get` returns before a
   long download finishes — it does **not** block to completion.

5. **Progress of active downloads:**
   ```bash
   nas-download status
   ```
   Shows each active download with speed, **ETA**, and downloaded-of-total.

6. **Import on completion (this is how it reaches Jellyfin):**
   After `get`, watch `status`; when the item hits **100%**, run:
   ```bash
   nas-download import "The Bear season 3"   # or no arg = import everything completed
   ```
   Idempotent (hardlinks into the library + triggers a Jellyfin scan; re-running is a no-op).
   If a download finishes instantly (cached), `get` imports it right away.

## Removing a title (delete — confirmation-gated)

Use when the user says "удали фильм/сериал X", "delete", "remove <title>". **NEVER delete
without an explicit user confirmation.**

1. **Plan (read-only — deletes nothing):**
   ```bash
   nas-download rm "Spider-Man 2 2004"
   ```
   Pass the **title + year** (and, if the file is stored under the other-language name, use
   that name — you know both). It lists every matching torrent + library file and the honest
   **reclaimable if ALL listed copies are removed** (inode-deduped; a dead entry frees 0, a
   lone hardlink frees nothing until its paired copy goes too).

2. **Confirm with the user** via `AskUserQuestion`: show the title and the reclaimable GB, ask
   "Точно удалить «X»? Освободится ~N GB." Wait for an explicit yes. Ambiguous / multiple
   distinct titles matched → ask which one.

3. **Delete only the confirmed selectors:**
   ```bash
   nas-download rm --torrent <hash> --path "<abs>" [--torrent …] [--path …] --apply
   ```
   Pass the torrent hash(es) **and** the library path(s) from the plan so the shared inode is
   fully freed. Reports freed space from a `df` before/after. Path deletion is guarded to the
   media/torrents roots (no `..`, nothing outside).

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
