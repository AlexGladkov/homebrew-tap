class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.5.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.5.0/monet-0.5.0.tar.gz"
  sha256 "cd1649156474b1a9f7497642e26218694af68524dab7fa8dcadb4f044c7bfa86"

  depends_on "node"

  def install
    libexec.install "monet.mjs"
    libexec.install "pi-assets"
    (bin/"monet").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/monet.mjs" "$@"
    SH
    (bin/"monet").chmod 0755
  end

  test do
    output = shell_output("#{bin}/monet --help 2>&1")
    assert_match "monet", output
  end
end
