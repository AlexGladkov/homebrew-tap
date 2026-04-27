class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.5.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.5.0/harnest-v0.5.0-darwin-arm64.tar.gz"
      sha256 "b9f8454d7205b42179115fb7559d81307ecf563c8f3aef06638efa2e35c84fc8"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.5.0/harnest-v0.5.0-darwin-amd64.tar.gz"
      sha256 "ca9d01f15260256d4d7062d0bff46e765ddfea3614a595e784b74f08edc5bc29"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.5.0/harnest-v0.5.0-linux-amd64.tar.gz"
    sha256 "cafc8718bfe13978bf15e61c4de3fe6b5a6271ffb8d07f641e05ea174d31cdad"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
