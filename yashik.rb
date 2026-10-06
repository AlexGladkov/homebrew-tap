class Yashik < Formula
  desc "Install and reconcile personal AI client environments"
  homepage "https://github.com/AlexGladkov/Yashik"

  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.3.0/yashik-macos-aarch64.tar.gz"
      sha256 "78dea6f490cf365a2895addd33f88c03c5a9bdd4e30964026dd32075004f38f9"
    end
    on_intel do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.3.0/yashik-macos-x86_64.tar.gz"
      sha256 "8026a7b61f163ada068b2ba776b2a7848163e4f97ebfe8cbe2341c8403076dc9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.3.0/yashik-linux-aarch64.tar.gz"
      sha256 "1a84743b79a37a8f5b6a0520e430f51129f93c728fc389a9ce00c9e05c591075"
    end
    on_intel do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.3.0/yashik-linux-x86_64.tar.gz"
      sha256 "75ce1f60f524ddf4c6a5a6d7b002359389f6595e710aab19441149c116a38722"
    end
  end

  def install
    bin.install "yashik"
  end

  test do
    assert_equal "yashik #{version}", shell_output("#{bin}/yashik --version").strip
    assert_match "Usage:", shell_output("#{bin}/yashik --help")
  end
end
