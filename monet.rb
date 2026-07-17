class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.6.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.6.0/monet-0.6.0.tar.gz"
  sha256 "95320ab2317b3f3de4491f04e3b628eba387a5bd9cf01066eb5e85485383c61e"

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
