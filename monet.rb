class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.3.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.3.0/monet-0.3.0.tar.gz"
  sha256 "bacc8bdb4588571c99ae8f835ffeca71c9d108414b091df29c2b4fab31567c71"

  depends_on "node"

  def install
    libexec.install "monet.mjs"
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
