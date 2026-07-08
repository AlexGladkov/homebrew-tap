class Quickai < Formula
  desc "Profiler for Claude Code — where your tokens, money and time go"
  homepage "https://github.com/AlexGladkov/quickai"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/quickai-v0.2.0/quickai-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "3546b5bea91246792a4105d9b2c4505e7b2fca238d3c57fb2a3189a32f1287ba"
    end
    on_intel do
      url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.2.0.tar.gz"
      sha256 "c78894d12cc45e62a5c4d16b184707452bce451cbe7f57203710246f15c11240"
      depends_on "rust" => :build
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.2.0.tar.gz"
    sha256 "c78894d12cc45e62a5c4d16b184707452bce451cbe7f57203710246f15c11240"
    depends_on "rust" => :build
  end

  def install
    if File.exist?("quickai")
      bin.install "quickai"            # prebuilt (Apple Silicon)
    else
      system "cargo", "install", *std_cargo_args   # build from source
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/quickai --version")
  end
end
