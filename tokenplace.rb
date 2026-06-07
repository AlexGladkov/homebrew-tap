class Tokenplace < Formula
  desc "CLI-first AI infrastructure marketplace for the Russian engineering market"
  homepage "https://github.com/AlexGladkov/tokenplace"
  version "0.13.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.13.2/tokenplace-0.13.2-aarch64-apple-darwin.tar.gz"
      sha256 "9c6409d3509cf2e92597fb63e3651c3a65aabc6c5e92a7d21aa7c81f9f2293ff"
    else
      odie "tokenplace 0.13.2 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
    end
  end

  on_linux do
    odie "tokenplace 0.13.2 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
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
