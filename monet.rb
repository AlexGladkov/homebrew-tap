class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.2.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.2.0/monet-0.2.0.tar.gz"
  sha256 "6b61621a5091a02ad0943db684742725a8c6a5a37e355f7bc49bfe847d5d8bbb"

  depends_on "node"

  def install
    bin.install "monet"
  end

  test do
    output = shell_output("#{bin}/monet 2>&1", 1)
    assert_match "monet", output
  end
end
