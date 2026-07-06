class Quickai < Formula
  desc "Profiler for Claude Code — where your tokens, money and time go"
  homepage "https://github.com/AlexGladkov/quickai"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/homebrew-tap/releases/download/quickai-v0.1.0/quickai-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "edc8092aa56df6a27cdaeb060a331d5fafd86be85b22dd5b9029aecfab686969"
    end
    on_intel do
      url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.1.0.tar.gz"
      sha256 "5e64bfc3f7081497417273d09f697aa70c90478beb277a0cc1c7164457a271f2"
      depends_on "rust" => :build
    end
  end

  on_linux do
    url "https://github.com/AlexGladkov/quickai/archive/refs/tags/v0.1.0.tar.gz"
    sha256 "5e64bfc3f7081497417273d09f697aa70c90478beb277a0cc1c7164457a271f2"
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
