# AlexGladkov Claude Code plugins + Homebrew tap

This repo is **both** a Claude Code plugin marketplace and a Homebrew tap.

## homecontrol — Claude Code skills for a home NAS

Skills to run your home NAS from Claude Code without re-entering context. Secrets in the
macOS keychain; personal infra in a local config (`~/.config/homecontrol/config`), never in
the code.

| Skill | What it does |
|-------|--------------|
| `nas-connect` | Connect to the NAS over ssh, verify sudo, list running services. |
| `nas-download` | Download movie/series/music — never avi, 1080p, free-space guard, auto-import, music via Soulseek. |
| `nas-cleanup` | Free space safely — honest reclaimable accounting; deletes only what you explicitly pick. |

---

## Install as a Claude Code plugin (recommended)

In Claude Code:
```
/plugin marketplace add AlexGladkov/homebrew-tap
/plugin install homecontrol@alexgladkov
```
That's it — the three skills register automatically (invoke as `/homecontrol:nas-connect`,
`/homecontrol:nas-download`, `/homecontrol:nas-cleanup`, or just ask in natural language). The
bundled `nas-connect` / `nas-download` commands are added to PATH while the plugin is enabled.

Manage:
```
/plugin list
/plugin uninstall homecontrol@alexgladkov
/plugin marketplace update alexgladkov     # after a new version
```

### Prerequisites (runtime)
- Keyless SSH to your NAS via a `Host` entry in `~/.ssh/config`:
  ```
  Host nas
      HostName 192.168.1.50        # your NAS IP/host
      User youruser
      IdentityFile ~/.ssh/id_ed25519
  ```
  `ssh nas true` must connect with no password prompt.

### First-time config
```bash
nas-connect config     # ssh alias / user / host → ~/.config/homecontrol/config
nas-connect setup      # NAS sudo password → macOS keychain (hidden dialog)
nas-connect            # connect + verify + list services
```

---

## Install as standalone CLIs (Homebrew, optional)

If you want the `nas-connect` / `nas-download` commands without the plugin:
```bash
brew trust AlexGladkov/tap
brew install AlexGladkov/tap/nas-connect AlexGladkov/tap/nas-download AlexGladkov/tap/nas-cleanup
mkdir -p ~/.claude/skills
for s in nas-connect nas-download nas-cleanup; do
  ln -sfn "$(brew --prefix)/opt/$s/share/$s/$s" ~/.claude/skills/$s
done
```

## Use
```bash
nas-download plan  "Dune 2021"                   # pick a release + check space (no download)
nas-download get   "The Bear season 3"           # download (force-started)
nas-download status                              # active downloads: speed / ETA / done-of-total
nas-download import "The Bear season 3"           # on 100% → hardlink into Jellyfin (idempotent)
nas-download get   "Daft Punk Discovery" --type music

# Delete a specific title — plan is read-only and shows how much frees; then confirm:
nas-download rm "Spider-Man 2 2004"              # lists matches + inode-deduped reclaimable
nas-download rm --torrent <hash> --path "<abs>" --apply   # deletes only these (guarded)

# nas-cleanup is LLM-driven — ask Claude to "free space on the NAS".
```
In Claude Code just ask in natural language ("скачай …", "удали фильм …") — the skills drive
these commands and hold the delete confirmation gate.
