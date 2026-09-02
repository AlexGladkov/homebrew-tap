# typed: false
# frozen_string_literal: true

# homecontrol · nas-download — installs from a PUBLIC generic release tarball (no ssh needed).
class NasDownload < Formula
  desc "Download a movie/series/music onto the NAS — never avi, 1080p, space-guarded"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/homecontrol-v0.6.0/homecontrol-0.6.0.tar.gz"
  sha256 "32ac6f00ead87b99900445e639a2b267d0db866baed0997f01010200e536d4ad"
  version "0.6.0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/nas-download.sh" => "nas-download"
    pkgshare.install ".claude/skills/nas-download"
  end

  def caveats
    <<~EOS
      Register the Claude skill (one-time):
        mkdir -p ~/.claude/skills
        ln -sfn #{opt_pkgshare}/nas-download ~/.claude/skills/nas-download

      Needs a configured NAS + keychain credential (see 'nas-connect config' / 'nas-connect setup').
      Usage:  nas-download plan "Dune 2021"   then   nas-download get "Dune 2021"
    EOS
  end

  test do
    system bin/"nas-download", "--help"
  end
end
