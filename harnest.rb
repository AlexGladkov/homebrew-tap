class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.4.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.4.0/harnest-v0.4.0-darwin-arm64.tar.gz"
      sha256 "4fa22af7f01709cbd4c68f9852c33cb52d0f8483c35beb4d15980a428dd3b260"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.4.0/harnest-v0.4.0-darwin-amd64.tar.gz"
      sha256 "e894b739d202b1046cf3ed65dffec614040bd2d05f53a901d32952d526e1065f"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.4.0/harnest-v0.4.0-linux-amd64.tar.gz"
    sha256 "bdf4a400899714f546a896e5b71f4c7f20a99d3c79d3b05670e72af18969c794"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
