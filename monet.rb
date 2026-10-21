class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.57.37"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.57.37/monet-0.57.37.tar.gz"
  sha256 "149a8b9f2e9815a5d79221e34dde5ee6baba7cef252b67507d6c559c690592e3"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/{monet,monet-ai}"]
  end

  test do
    assert_match "monet", shell_output("#{bin}/monet --help 2>&1")
  end
end
