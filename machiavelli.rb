class Machiavelli < Formula
  desc "Portable corporate-ontology CLI + ethical intrigue advisor"
  homepage "https://github.com/AlexGladkov/machiavelli"
  version "0.1.1"
  license "MIT"

  url "https://github.com/AlexGladkov/machiavelli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "11173eeea5367f06c7fb78955d4459370a08174dcf31996a99672c3abfa59e6c"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    (bin/"machiavelli").write <<~SH
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/core/machiavelli.cjs" "$@"
    SH
    chmod 0755, bin/"machiavelli"

    (bin/"machiavelli-setup").write <<~SH
      #!/bin/bash
      exec bash "#{libexec}/install.sh" "$@"
    SH
    chmod 0755, bin/"machiavelli-setup"
  end

  def caveats
    <<~EOS
      CLI installed as `machiavelli`.
      Wire host adapters (Claude Code / Codex / OpenCode):
        machiavelli-setup --host claude
      Set your LLM key:
        export MACH_LLM_KEY=sk-ant-...
    EOS
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/machiavelli version --json")
  end
end
