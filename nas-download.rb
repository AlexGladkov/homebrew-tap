# typed: false
# frozen_string_literal: true

# homecontrol · nas-download — installs from a PUBLIC generic release tarball (no ssh needed).
class NasDownload < Formula
  desc "Download a movie/series/music onto the NAS — never avi, 1080p, space-guarded"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/homecontrol-v0.5.0/homecontrol-0.5.0.tar.gz"
  sha256 "3b5f68d975eec74ae582878285d6ecc6843d9c5f463d03ff995f1c86435f6304"
  version "0.5.0"
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
