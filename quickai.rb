class Quickai < Formula
  desc "Profiler for Claude Code — where your tokens, money and time go"
  homepage "https://github.com/AlexGladkov/quickai"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/quickai-v0.3.0/quickai-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "0258dbfacdcc86e9f439e3bbeb23442c6b444bc548c7fbceaad33088e98dc7e8"
    end
    on_intel do
      url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.3.0.tar.gz"
      sha256 "48a9b97d7d45ee4018a62dd136f33cce26cf8bbb7d7bbcc72f0888afffa3c276"
      depends_on "rust" => :build
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.3.0.tar.gz"
    sha256 "48a9b97d7d45ee4018a62dd136f33cce26cf8bbb7d7bbcc72f0888afffa3c276"
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
