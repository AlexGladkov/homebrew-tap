class Harnest < Formula
  desc "AI coding assistant configurator - detects stack, generates agent configs"
  homepage "https://github.com/AlexGladkov/harnest"
  version "0.1.0"
  license "CC-BY-NC-4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.1.0/harnest-darwin-arm64"
      sha256 "d22ac3645d111ec5ec459ca993700fe1afc62907f0e7eaabc7b41749762f3890"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.1.0/harnest-darwin-amd64"
      sha256 "376a5c19354a8dd297d01b468281dbe0e15fb14b777536f7d867fddd889284ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.1.0/harnest-linux-arm64"
      sha256 "d29d140e8260ce15dbf04ce622c477b699944401f97ba91337bdef12cd4ecb8c"
    else
      url "https://github.com/AlexGladkov/harnest/releases/download/v0.1.0/harnest-linux-amd64"
      sha256 "ff67164e25a4f941ba2772b0c06b863de54e3ec45f61343fc79c28638b9f619b"
    end
  end

  def install
    binary = Dir["harnest-*"].first || "harnest"
    bin.install binary => "harnest"
  end

  test do
    assert_match "harnest v#{version}", shell_output("#{bin}/harnest version")
  end
end
