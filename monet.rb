class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.18.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.18.0/monet-0.18.0.tar.gz"
  sha256 "9acc46b9091aa5bed640f6b3514a423bb8ea5c21861be30fa0336e45247dec59"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/monet"]
  end

  test do
    assert_match "monet", shell_output("#{bin}/monet --help 2>&1")
  end
end
