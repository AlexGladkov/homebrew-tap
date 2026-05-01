class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.10.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.10.0/harnest-v0.10.0-darwin-arm64.tar.gz"
      sha256 "9da3d49643177f1d58fdb7b604d9c52ba0448c5788626582de845738e0345cc2"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.10.0/harnest-v0.10.0-darwin-amd64.tar.gz"
      sha256 "ea9f90b19d496ddfc99f946b3f02c019fa110d365c1c636b6111dc625070ec7a"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.10.0/harnest-v0.10.0-linux-amd64.tar.gz"
    sha256 "1f36947e723b06920b79d9b16e3dd16b71d545c8a64b58ca73b2f63ab51f277e"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
