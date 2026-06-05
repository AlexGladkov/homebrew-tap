class Personality < Formula
  desc "Self-hosted personality framework — second-self AI agents (REPL + plugins)"
  homepage "https://github.com/AlexGladkov/homebrew-tap"
  version "0.5.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/v0.5.1/personality-darwin-arm64-v0.5.1.tar.gz"
      sha256 "c5352903ee0f1a976f935a0b67f7ef2dcb39d0259402e7f1ed6e5d47ad983e84"
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
