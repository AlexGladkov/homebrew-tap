class Tokenplace < Formula
  desc "CLI-first AI infrastructure marketplace for the Russian engineering market"
  homepage "https://github.com/AlexGladkov/tokenplace"
  version "0.17.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.17.5/tokenplace-0.17.5-aarch64-apple-darwin.tar.gz"
      sha256 "6801650c49aa0c651c0206b5606e05a7c0ec8417c257b3eabf588f8e560496fa"
    else
      odie "tokenplace 0.17.5 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
    end
  end

  on_linux do
    odie "tokenplace 0.17.5 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
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
