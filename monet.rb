class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.30.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.30.0/monet-0.30.0.tar.gz"
  sha256 "b73956a7e20c2387d23a90737d56932d892a7f007126ce37603a2f58c47879fc"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/monet"]
  end

  test do
    assert_match "monet", shell_output("#{bin}/monet --help 2>&1")
  end
end
