class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.2.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.2.0/harnest-v0.2.0-darwin-arm64.tar.gz"
      sha256 "74c548303f2391d4e85add7ab80913e70ac78e6ccfcb0d0a0b83eb3c0727b2c1"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.2.0/harnest-v0.2.0-darwin-amd64.tar.gz"
      sha256 "b73c7a7dc78673bb255eec0148baf303dd144e8e070ad115728050dfbdfa4052"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.2.0/harnest-v0.2.0-linux-amd64.tar.gz"
    sha256 "584547982cfabdc0922f7b69df69522003cabb7b2c5397090d8f5a427f58188d"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
