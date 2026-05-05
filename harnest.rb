class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.11.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.11.0/harnest-v0.11.0-darwin-arm64.tar.gz"
      sha256 "246e0fa857d25e5cf4da6870f205698dd2cfd7ce3c6282142797f6c236e3998a"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.11.0/harnest-v0.11.0-darwin-amd64.tar.gz"
      sha256 "eeb07b24a7843af7858e2b5385753e7c414ecab16241177b6c4e5d849dad85f2"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.11.0/harnest-v0.11.0-linux-amd64.tar.gz"
    sha256 "34d52dd09010dc1fe06dffbee4857ca72a1d5099409506ae1146583359723334"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
