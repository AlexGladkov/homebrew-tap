# typed: false
# frozen_string_literal: true

# homecontrol · media-get — installs from a PUBLIC generic release tarball (no ssh needed).
class MediaGet < Formula
  desc "Download a movie/series/music onto the NAS — never avi, 1080p, space-guarded"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/homecontrol-v0.3.0/homecontrol-0.3.0.tar.gz"
  sha256 "a52c6eb4a9f56458810c3317a80054473326bcdf61e2b6529f72f5373dfa9a5b"
  version "0.3.0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/media-get.sh" => "media-get"
    pkgshare.install ".claude/skills/media-get"
  end

  def caveats
    <<~EOS
      Register the Claude skill (one-time):
        mkdir -p ~/.claude/skills
        ln -sfn #{opt_pkgshare}/media-get ~/.claude/skills/media-get

      Needs a configured NAS + keychain credential (see 'nas-connect config' / 'nas-connect setup').
      Usage:  media-get plan "Dune 2021"   then   media-get get "Dune 2021"
    EOS
  end

  test do
    system bin/"media-get", "--help"
  end
end
