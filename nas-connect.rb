# typed: false
# frozen_string_literal: true

# homecontrol · nas-connect — installs from the PRIVATE AlexGladkov/homecontrol repo
# via git+ssh (needs your GitHub ssh key; not installable by others by design).
class NasConnect < Formula
  desc "Connect to the home NAS with keychain-backed sudo (homecontrol skill)"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "ssh://git@github.com/AlexGladkov/homecontrol.git",
      using:    :git,
      tag:      "v0.2.0",
      revision: "b6173bdfc288b145998a1f961ab35c3f19c6c2c7"
  version "0.2.0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/nas-connect.sh" => "nas-connect"
    pkgshare.install ".claude/skills/nas-connect"
  end

  def caveats
    <<~EOS
      Register the Claude skill (one-time):
        mkdir -p ~/.claude/skills
        ln -sfn #{opt_pkgshare}/nas-connect ~/.claude/skills/nas-connect

      Then:
        nas-connect setup   # store NAS sudo password in the macOS keychain (secure GUI)
        nas-connect         # connect + verify + list live services
    EOS
  end

  test do
    system bin/"nas-connect", "--help"
  end
end
