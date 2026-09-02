# typed: false
# frozen_string_literal: true

# homecontrol · media-get — installs from the PRIVATE AlexGladkov/homecontrol repo via git+ssh.
class MediaGet < Formula
  desc "Download a movie/series/music onto the NAS — never avi, 1080p, space-guarded"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "ssh://git@github.com/AlexGladkov/homecontrol.git",
      using:    :git,
      tag:      "v0.2.1",
      revision: "f9d70578074a067f9a50c5018bbdd216be59ea4e"
  version "0.2.1"
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

      Needs the NAS credential in the keychain (run 'nas-connect setup' if missing).
      Usage:  media-get plan "Дюна 2021"   then   media-get get "Дюна 2021"
    EOS
  end

  test do
    system bin/"media-get", "--help"
  end
end
