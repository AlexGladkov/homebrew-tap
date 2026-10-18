class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.57.24"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.57.24/monet-0.57.24.tar.gz"
  sha256 "9351f59c0817c36dfa3475b8f653eac0cac4916e9c8a13a027f6e93176d2e8a2"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/{monet,monet-ai}"]
  end

  test do
    assert_match "monet", shell_output("#{bin}/monet --help 2>&1")
  end
end
