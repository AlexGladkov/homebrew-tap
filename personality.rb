class Personality < Formula
  desc "Self-hosted personality framework — second-self AI agents (REPL + plugins)"
  homepage "https://github.com/AlexGladkov/homebrew-tap"
  version "0.4.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/v0.4.1/personality-darwin-arm64-v0.4.1.tar.gz"
      sha256 "35642ee98b229d33ac5a00f7e0e901bb1e653af754418f991f446a35395ac2d0"
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
