class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.3.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-arm64.tar.gz"
      sha256 "85b84a2d4f15b5b49041cad33529cd216c3a23aff4b1f4ca7d6e1c1317662f1a"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-amd64.tar.gz"
      sha256 "0b5b5edd6a3ab2f6640af8d992bb3c135fb8773325217f9cd2bfb7b87f0bc538"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-linux-amd64.tar.gz"
    sha256 "7589c85795fb581f47de45b1b09bed1d99012a9a097530b736f16db8d74c5490"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
