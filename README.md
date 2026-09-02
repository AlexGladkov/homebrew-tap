# AlexGladkov Homebrew Tap

Homebrew formulae for AlexGladkov projects.

```bash
brew tap AlexGladkov/tap
```

Formulae are code, so recent Homebrew requires trusting the tap once:
```bash
brew trust AlexGladkov/tap
```

---

## homecontrol — Claude Code skills for a home NAS

Spec-driven Claude Code skills to run your home NAS without re-entering context. Secrets in
the macOS keychain; personal infra in a local config, never in the code.

| Formula | Skill |
|---------|-------|
| `nas-connect` | Connect to the NAS over ssh, verify sudo, list running services. |
| `media-get` | Download movie/series/music — never avi, 1080p, free-space guard, auto-import, music via Soulseek. |
| `nas-cleanup` | Free space safely — honest reclaimable accounting, deletes only what you explicitly pick. |

### Prerequisites
- Homebrew (macOS).
- Keyless SSH to your NAS via a `Host` entry in `~/.ssh/config`:
  ```
  Host nas
      HostName 192.168.1.50        # your NAS IP/host
      User youruser
      IdentityFile ~/.ssh/id_ed25519
  ```
  `ssh nas true` must connect with no password prompt.

### Install
```bash
brew trust AlexGladkov/tap                       # once
brew install AlexGladkov/tap/nas-connect \
             AlexGladkov/tap/media-get \
             AlexGladkov/tap/nas-cleanup

# register the skills with Claude Code:
mkdir -p ~/.claude/skills
for s in nas-connect media-get nas-cleanup; do
  ln -sfn "$(brew --prefix)/opt/$s/share/$s/$s" ~/.claude/skills/$s
done
```

### Configure
```bash
nas-connect config     # ssh alias / user / host → ~/.config/homecontrol/config
nas-connect setup      # NAS sudo password → macOS keychain (hidden dialog)
nas-connect            # connect + verify + list services
```

### Use
```bash
media-get plan "Dune 2021"                    # pick a release + check space (no download)
media-get get  "The Bear season 3"            # download + auto-import into Jellyfin
media-get get  "Daft Punk Discovery" --type music
# nas-cleanup is an LLM-driven skill — ask Claude to "free space on the NAS".
```

### Update
```bash
brew update && brew upgrade nas-connect media-get nas-cleanup
```
