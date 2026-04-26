class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.3.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-arm64.tar.gz"
      sha256 "ab915d13459e3113936e3d77ac70bed19a06aa6b47a8b7cda7b0ad89e270d9c6"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-darwin-amd64.tar.gz"
      sha256 "621fb7b642ce54c253065c5b24a534e19b9d158ef2a2400b3247ab14c4663c16"
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/harnest/releases/download/v0.3.0/harnest-v0.3.0-linux-amd64.tar.gz"
    sha256 "7681f9758cb9d4e50a58a84a78f4b2d0d6f8493d2930f799d7986107b1ec409d"
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
