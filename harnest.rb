class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.3.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-arm64.tar.gz"
      sha256 "4f42a507ed85a014d2abd1134442e7170f8ea23f7075eae1a33d7102d81f4568"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-amd64.tar.gz"
      sha256 "5bdb439fe63143a71d565f651abc188be471e0cd18866df0325ec8779c546868"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-linux-amd64.tar.gz"
    sha256 "1e08f589fcb43ea1a48412a2c67d9a02b4e53b70c0753aadbbbb5050de11bb22"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
