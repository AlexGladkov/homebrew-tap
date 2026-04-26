class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.3.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-arm64.tar.gz"
      sha256 "ce81614952a149bc9c5293bebcbad7b127637b3b2e2878747718cdd1bfea591f"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-amd64.tar.gz"
      sha256 "0bedd13dfd2d2846e5d9de125391d5ce84030c39e4822869053c5db4f30b74d2"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-linux-amd64.tar.gz"
    sha256 "6a573fd7de5b7f42887cb51df9f8bf04b4516c7108b4824765f942623a1d9740"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
