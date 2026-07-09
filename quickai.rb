class Quickai < Formula
  desc "Profiler for Claude Code — where your tokens, money and time go"
  homepage "https://github.com/AlexGladkov/quickai"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/quickai-v0.4.0/quickai-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "b56efa292a62cfb791971795212498dba26f19b9e5ff5ca9988d9abdb15323cc"
    end
    on_intel do
      url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.4.0.tar.gz"
      sha256 "89f593c96f7fa784c5a58ac4dba772317b5ca0801287f79802f73f6218edb111"
      depends_on "rust" => :build
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.4.0.tar.gz"
    sha256 "89f593c96f7fa784c5a58ac4dba772317b5ca0801287f79802f73f6218edb111"
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
