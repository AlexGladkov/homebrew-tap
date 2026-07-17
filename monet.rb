class Monet < Formula
  desc "Personal AgentOS — agents that manage agents (fork of pi.dev)"
  homepage "https://github.com/AlexGladkov/monet"
  version "0.4.0"
  license "MIT"

  url "https://github.com/AlexGladkov/homebrew-tap/releases/download/monet-v0.4.0/monet-0.4.0.tar.gz"
  sha256 "86c46de21f9b7d7bb675fb19195effbb3b14d66e5af9af1fd2d29a36c5a1faf2"

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
