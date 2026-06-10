class Tokenplace < Formula
  desc "CLI-first AI infrastructure marketplace for the Russian engineering market"
  homepage "https://github.com/AlexGladkov/tokenplace"
  version "0.24.1"

  depends_on "ollama"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.24.1/tokenplace-0.24.1-aarch64-apple-darwin.tar.gz"
      sha256 "2fe84686603bb37c3a1f9180eb6320bf23b4f304a72b4f74e44541683949128c"
    else
      odie "tokenplace 0.24.1 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.24.1/tokenplace-0.24.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fe84686603bb37c3a1f9180eb6320bf23b4f304a72b4f74e44541683949128c"
    else
      odie "tokenplace 0.24.1 ships only linux-x86_64 binaries via brew on Linux. Build from source: https://github.com/AlexGladkov/tokenplace"
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
