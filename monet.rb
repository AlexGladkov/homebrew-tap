class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.57.40"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.57.40/monet-0.57.40.tar.gz"
  sha256 "8955221664eeeb1859d3b5e172b1bdd26c28cd174c417d93e3e75efbe7c7a895"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/{monet,monet-ai}"]
  end

  test do
    assert_match "monet", shell_output("#{bin}/monet --help 2>&1")
  end
end
