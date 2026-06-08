class Tokenplace < Formula
  desc "CLI-first AI infrastructure marketplace for the Russian engineering market"
  homepage "https://github.com/AlexGladkov/tokenplace"
  version "0.17.7"

  depends_on "ollama"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.17.7/tokenplace-0.17.7-aarch64-apple-darwin.tar.gz"
      sha256 "2db197ca97f00dc7ee149a4d6f5682ca5947f0ec62a4b05d6cd3e2f84224e3c0"
    else
      odie "tokenplace 0.17.7 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.17.7/tokenplace-0.17.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b382579d26b642550b07451a4bbff2eb38535772c322894351f9eaf70d5392e6"
    else
      odie "tokenplace 0.17.7 ships only linux-x86_64 binaries via brew on Linux. Build from source: https://github.com/AlexGladkov/tokenplace"
    end
  end

  def install
    bin.install "tokenplace"
    bin.install "tp-host-daemon"
  end

  def caveats
    <<~EOS
      A second binary `tp-host-daemon` is installed alongside `tokenplace`.
      It is launched by launchd when you publish a model via the TUI — do not delete it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tokenplace --version")
    assert_match version.to_s, shell_output("#{bin}/tp-host-daemon --version")
  end
end
