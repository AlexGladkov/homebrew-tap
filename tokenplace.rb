class Tokenplace < Formula
  desc "CLI-first AI infrastructure marketplace for the Russian engineering market"
  homepage "https://github.com/AlexGladkov/tokenplace"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/tokenplace-v0.8.0/tokenplace-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "a4f142511e8098fb2035f90dbaef5a71594768175d1850ea6af24ce4bfb1f3d9"
    else
      odie "tokenplace 0.8.0 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
    end
  end

  on_linux do
    odie "tokenplace 0.8.0 ships only darwin-arm64 binaries via brew. Build from source: https://github.com/AlexGladkov/tokenplace"
  end

  def install
    bin.install "tokenplace"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tokenplace --version")
  end
end
