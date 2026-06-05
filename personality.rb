class Personality < Formula
  desc "Self-hosted personality framework — second-self AI agents (REPL + plugins)"
  homepage "https://github.com/AlexGladkov/homebrew-tap"
  version "0.7.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/v0.7.1/personality-darwin-arm64-v0.7.1.tar.gz"
      sha256 "09049ca44f87f916616854caf893a295a81b6f034261c66a654ebadb764c041f"
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
