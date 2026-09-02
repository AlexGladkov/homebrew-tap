# typed: false
# frozen_string_literal: true

# homecontrol · nas-connect — installs from a PUBLIC generic release tarball (no ssh needed).
# Personal NAS config lives in ~/.config/homecontrol/config (nas-connect config).
class NasConnect < Formula
  desc "Connect to a home NAS over ssh with a keychain-backed sudo password (homecontrol skill)"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/homecontrol-v0.5.0/homecontrol-0.5.0.tar.gz"
  sha256 "3b5f68d975eec74ae582878285d6ecc6843d9c5f463d03ff995f1c86435f6304"
  version "0.5.0"
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

      Configure + store the NAS password:
        nas-connect config    # ssh alias / user / host → ~/.config/homecontrol/config
        nas-connect setup     # NAS sudo password → macOS keychain (hidden dialog)
        nas-connect           # connect + verify + list services
    EOS
  end

  test do
    system bin/"nas-connect", "--help"
  end
end
