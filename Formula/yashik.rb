class Yashik < Formula
  desc "Install and reconcile personal AI client environments"
  homepage "https://github.com/AlexGladkov/Yashik"

  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.4.0/yashik-macos-aarch64.tar.gz"
      sha256 "1d951df998146795472aeda5447aa5cf8413f1d8cc1dfb846a8debaaa639b237"
    end
    on_intel do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.4.0/yashik-macos-x86_64.tar.gz"
      sha256 "67c26b4ad3de68839394ff5b289589f27c2b24c5b4d9381d73d1627bd1e16362"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.4.0/yashik-linux-aarch64.tar.gz"
      sha256 "aa29f28a3d6d9e133bec22b935546c55e10393eaa85cc0c9d3362dbce8f4756a"
    end
    on_intel do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.4.0/yashik-linux-x86_64.tar.gz"
      sha256 "20054f552918620befc8ce8092fbfaeec5302b9df7699b48ca5e7ac48b8d8b75"
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
