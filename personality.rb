class Personality < Formula
  desc "Self-hosted personality framework — second-self AI agents (REPL + plugins)"
  homepage "https://github.com/AlexGladkov/homebrew-tap"
  version "0.2.5"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/v0.2.5/personality-darwin-arm64-v0.2.5.tar.gz"
      sha256 "f7a198a7ea10f550bd9f46236d17a108d9bc86526652201f09ece622c4ad4ea1"
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
