---
name: nas-connect
description: Connect to a home NAS over ssh and run privileged (docker/root) ops without re-entering context. Reads the NAS sudo password from the macOS login keychain (stored via a secure GUI prompt, never pasted in chat). Config-driven — the NAS ssh alias/user/host live in ~/.config/homecontrol/config, not in the code. Use when the user wants to connect to the NAS, run docker/root operations on it, check home services (Jellyfin/qBit/Prowlarr), or says "/nas-connect", "подключись к nas", "connect to nas".
---

# nas-connect

Connects to a NAS over a keyless `ssh` alias and verifies privileged access using the
sudo password kept in the macOS login keychain. No secret is ever typed into chat, shell
history, or a process argument. All NAS specifics are config-driven.

## Helper

Logic lives in `bin/nas-connect.sh` (installed on PATH as `nas-connect`). Prefer the
installed command; fall back to the repo path.

## First-time configuration

The NAS ssh alias (from `~/.ssh/config`), user and host label live in
`~/.config/homecontrol/config` — never hardcoded. Set them once:
```bash
nas-connect config                       # GUI prompts, or:
nas-connect config --alias nas --user <user> --host <ip-or-host>
```
Then store the sudo password securely:
```bash
nas-connect setup                        # hidden macOS dialog → keychain
```

## When invoked

1. **Connect (default):**
   ```bash
   nas-connect
   ```
   Asserts the ssh alias is keyless, reads the sudo password from the keychain, verifies
   `sudo id`→uid=0, and prints the live docker service list.

2. **Missing credential:** if connect exits with `no credential in keychain`, run
   `nas-connect setup`, then re-run.

## Error map

| Message | Meaning | Fix |
|---|---|---|
| `NAS unreachable, or key not installed` | ssh alias failed | check `~/.ssh/config`, the ssh key, NAS online; `nas-connect config` |
| `no credential in keychain` | secret not stored | `nas-connect setup` |
| `sudo failed — wrong password?` | keychain password rejected | `nas-connect setup` again with the correct password |

## Notes

- Config: `~/.config/homecontrol/config` (`NAS_SSH_ALIAS`, `NAS_USER`, `NAS_HOST`, …).
  The real host/user/key live in `~/.ssh/config`; this repo ships no personal data.
- The sudo password reaches the NAS via ssh **stdin** into `sudo -S`, never on an argv.
- Do NOT print the password or echo it back to the user.
