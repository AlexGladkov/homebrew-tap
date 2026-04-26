class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.3.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-arm64.tar.gz"
      sha256 "94a583a0f1f865324db55cddcc19ae0c578e54d589e3689820eb536f05cbd567"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-amd64.tar.gz"
      sha256 "fc8dcb2b000f3b79f7d55e4950ff096b475bb90fec2ff5041a9d9ed1d06f43a8"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-linux-amd64.tar.gz"
    sha256 "bd63ee5e251dd3ccfc2bea4fb78212aca7e7fcc2bcaa6539727c53c3f21ab6ca"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
