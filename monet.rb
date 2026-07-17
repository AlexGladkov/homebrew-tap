class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.1.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.1.0/monet-0.1.0.tar.gz"
  sha256 "d89d4f4f76a19e7ec8116b25cceb7c2db00e07d1c111072d30c2ae3c87ffb60c"

  depends_on "node"

  def install
    bin.install "monet"
  end

  test do
    # без аргументов monet печатает usage в stderr и выходит с кодом 1
    output = shell_output("#{bin}/monet 2>&1", 1)
    assert_match "monet", output
  end
end
