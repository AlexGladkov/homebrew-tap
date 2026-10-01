class Yashik < Formula
  desc "Install and reconcile personal AI client environments"
  homepage "https://github.com/AlexGladkov/Yashik"

  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.2.1/yashik-macos-aarch64.tar.gz"
      sha256 "cc11ec64fbdbbdc2498108d9de86799b19c5e1288c699edf02050b6bb454e1b0"
    end
    on_intel do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.2.1/yashik-macos-x86_64.tar.gz"
      sha256 "491a0d326012ed0e038d4652a6481f59bde526a8a8e65b05e769dff6b355f20c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.2.1/yashik-linux-aarch64.tar.gz"
      sha256 "3e3d167e356d4cc385c10878ddf338a5060886382d0cc14415f0bf7b320b6486"
    end
    on_intel do
      url "https://github.com/AlexGladkov/Yashik/releases/download/v0.2.1/yashik-linux-x86_64.tar.gz"
      sha256 "ca0e44ebe46acb2d6f170435d1ce53664a326d3ce48e7702b29cce48526cf200"
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
