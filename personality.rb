class Personality < Formula
  desc "Self-hosted personality framework — second-self AI agents (REPL + plugins)"
  homepage "https://github.com/AlexGladkov/homebrew-tap"
  version "0.6.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/v0.6.1/personality-darwin-arm64-v0.6.1.tar.gz"
      sha256 "1fca69332d204400accd663aef3ea2409ee49cedccce229674325febf5520ef4"
    end
    # Intel build ships with the next CI-driven release.
  end

  def install
    bin.install "personality"
    bin.install "prsn"
  end

  test do
    assert_match "personality", shell_output("#{bin}/personality version")
  end
end
