---
name: nas-cleanup
description: Free space on the home NAS by finding and (only on explicit user confirmation) deleting large or junk media — big torrents, watched items, samples/rar junk, duplicates. Shows candidates with sizes, asks what to remove, deletes the chosen ones, reports space freed. NEVER deletes without the user explicitly picking. Use when the user says "освободи место", "почисти nas", "удали что-нибудь", "free space", "cleanup", "delete", or media-get reported insufficient space.
---

# nas-cleanup

You (Claude) run this yourself with bash/ssh — this is a procedure, not a CLI. Use your
judgment, show candidates, and **only delete what the user explicitly picks**.

## Plumbing (reuse nas-connect)

Read the NAS sudo password from the keychain and run privileged commands the same way
`nas-connect` does — the password travels over ssh **stdin** into `sudo -S`, never on argv:

```bash
CFG="${HOMECONTROL_CONFIG:-$HOME/.config/homecontrol/config}"; [ -f "$CFG" ] && . "$CFG"
: "${NAS_SSH_ALIAS:=nas}" "${NAS_USER:=nas}" "${NAS_VOLUME:=/volume1}"
PW="$(security find-generic-password -s "${KEYCHAIN_SERVICE:-homecontrol-nas}" -a "${KEYCHAIN_ACCOUNT:-$NAS_USER}" -w)"
nas_sudo(){ printf '%s\n' "$PW" | ssh -o BatchMode=yes "$NAS_SSH_ALIAS" "sudo -S -p '' sh -c \"$1\""; }
```
If the keychain has no credential, tell the user to run `nas-connect setup` and stop.
Do NOT print `$PW`.

## Procedure

1. **Free space now:** `nas_sudo "df -k $NAS_VOLUME"` → show current free.

2. **Gather candidates** (read-only — gather, don't delete). The torrent `size` field is
   METADATA, not disk usage — never present it as reclaimable. For every candidate compute
   the **real reclaimable bytes** with this algorithm:

   a. List torrents: `nas_sudo "/usr/local/bin/docker exec prowlarr curl -s http://qbittorrent:8080/api/v2/torrents/info"` → for each get `name`, `hash`, `state`, `content_path`, `ratio`.
   b. **Dead entry?** If `state == missingFiles` or `nas_sudo "test -e '<content_path>'"` is
      false → the data is already gone. **Reclaimable = 0 GB** — label it "dead entry (tidies
      the qBit list, frees nothing)". These are safe to remove but don't free space.
   c. **Real on-disk size:** for live ones, `nas_sudo "du -sk '<content_path>'"` (actual blocks,
      not the torrent size).
   d. **Hardlinked into the library?** This stack imports via `cp -al` (hardlink) — a torrent
      file and its library copy are the SAME inode, so deleting only the torrent link frees
      **~0** (the library still references the data on the same volume). Detect it:
      `nas_sudo "find '<content_path>' -type f -links +1 | head -1"` (link count > 1) OR match
      the basename under `$NAS_VOLUME/data/media`. If hardlinked → reclaimable ≈ 0, label
      "also in library — removing the torrent only stops seeding, frees ~0".
   e. **Genuinely reclaimable** = live, single-link, NOT in the library. Those are the real
      space wins; sort by their `du` size.

   Also gather:
   - **Large media dirs:** `nas_sudo "du -sk $NAS_VOLUME/data/media/movies/* $NAS_VOLUME/data/media/tv/* 2>/dev/null | sort -rn | head -20"` (deleting a library title frees its blocks unless it too is hardlinked to a live torrent).
   - **Junk:** `nas_sudo "find $NAS_VOLUME/data/torrents -iregex '.*\\(sample\\|trailer\\|\\.rar\\|\\.nfo\\|\\.r[0-9][0-9]\\)' 2>/dev/null | head -40"` (verify size with `du`).
   - **Watched (optional)** — query Jellyfin for played items (needs its token; ask first).

3. **Show a table** grouped by honesty: **Reclaimable now** (real `du` GB) / **Dead entries**
   (0 GB, list-only) / **In library / hardlinked** (0 GB). Sort each by real size. Do NOT pick
   for them. Never call an imported movie "junk".

4. **Ask the user** exactly what to delete (`AskUserQuestion` or plain question). Wait for an
   explicit selection. Ambiguous / "everything" → ask again with the concrete list.

5. **Delete only the chosen items:**
   - torrent + its files: `nas_sudo "/usr/local/bin/docker exec prowlarr curl -s --data 'hashes=<HASH>' -d deleteFiles=true http://qbittorrent:8080/api/v2/torrents/delete"`.
   - a media file/dir not in a torrent: `nas_sudo "rm -rf '<absolute-path>'"` — only paths you showed and the user picked.
   - then trigger a Jellyfin library scan (see the media-get import step) so removed items disappear.

6. **Report:** `df -k` again → **freed = before − after** (ground truth). If you removed a
   dead-entry or hardlinked item and `df` barely moved, say so honestly ("removed N dead
   entries; disk unchanged, as expected") — don't claim phantom GB.

## Invariants (STRICT — this skill deletes, so be careful)

- **Never delete anything the user did not explicitly pick.** No defaults, no "clean all".
- **No wildcard / bulk `rm`** beyond the exact paths shown and selected.
- Only `rm -rf` **absolute** paths under `$NAS_VOLUME/data/{media,torrents}` that you listed
  as candidates — never a parent dir, never `$NAS_VOLUME` itself, never a path with `..`.
- Always show `df` before and after so the freed amount is verifiable.
- Deleting a torrent uses qBit `deleteFiles=true` (removes the torrent + its data together);
  don't `rm` a torrent's files out from under qBit.
- If unsure whether something is safe to delete, ask — don't guess.
