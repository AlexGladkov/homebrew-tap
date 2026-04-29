class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.7.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.7.0/harnest-v0.7.0-darwin-arm64.tar.gz"
      sha256 "c1d413a80745236a7fe58b6e476e37becd5095c3eb757f6468f020192dfd977b"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.7.0/harnest-v0.7.0-darwin-amd64.tar.gz"
      sha256 "39e169ffd4e5476cf39a53468922e6fb2981e48814ca7288d765fa8953e5d475"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.7.0/harnest-v0.7.0-linux-amd64.tar.gz"
    sha256 "957297a143e2fcc60dcaff24b97b7567bd0f6fd68b4c8cf2dca5cd29a45dae60"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
