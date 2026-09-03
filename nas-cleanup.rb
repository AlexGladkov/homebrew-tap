# typed: false
# frozen_string_literal: true

# homecontrol · nas-cleanup — LLM-native skill (SKILL.md, no CLI). Public generic tarball.
class NasCleanup < Formula
  desc "Free NAS space safely — confirmation-gated deletion with honest reclaimable accounting"
  homepage "https://github.com/AlexGladkov/homecontrol"
  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/homecontrol-v0.7.0/homecontrol-0.7.0.tar.gz"
  sha256 "906d654db3b91390d935c2d5c17ca58757e5a45325c9bb1cfbda9bf7a8edbf37"
  version "0.7.0"
  license "MIT"

  depends_on :macos

  def install
    pkgshare.install ".claude/skills/nas-cleanup"
  end

  def caveats
    <<~EOS
      Register the Claude skill (one-time):
        mkdir -p ~/.claude/skills
        ln -sfn #{opt_pkgshare}/nas-cleanup ~/.claude/skills/nas-cleanup

      Reuses the nas-connect keychain credential. It gathers deletion candidates, shows
      honest reclaimable sizes, asks what to remove, and never deletes without your pick.
    EOS
  end

  test do
    assert_predicate opt_pkgshare/"nas-cleanup/SKILL.md", :exist?
  end
end
