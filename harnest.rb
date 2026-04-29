class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.6.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.6.0/harnest-v0.6.0-darwin-arm64.tar.gz"
      sha256 "a63837b9bccc90fadc34964396981877d3788d70a0bf30d8d2edd20bb608a4ba"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.6.0/harnest-v0.6.0-darwin-amd64.tar.gz"
      sha256 "e2d699d829e6c4e65095b76ecda5da15a5af618986d2a91104458468ce54332a"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.6.0/harnest-v0.6.0-linux-amd64.tar.gz"
    sha256 "e267723d20554ae1a6b73fa1668837fa9b51969194e9fffac9b9764ed28597da"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
