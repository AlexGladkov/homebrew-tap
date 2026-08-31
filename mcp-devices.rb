class McpDevices < Formula
  desc "Fast native CLI for mobile device automation (Android/iOS/Aurora/Desktop)"
  homepage "https://github.com/AlexGladkov/claude-in-mobile"
  version "4.1.0"
  license "MIT"

  # Renamed from claude-in-mobile in 4.0 — `brew upgrade claude-in-mobile`
  # migrates existing installs to this formula.
  oldname "claude-in-mobile"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-arm64.tar.gz"
      sha256 "6a2c0a56c6b7ecb34eb9f0560d74d91132af33f9b2bb937ca936627f343c70d9"
    end
    on_intel do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-x86_64.tar.gz"
      sha256 "118ee8da449bedd97298cf21e90d48f7a8acf2ab57c609dadbaadf83ba625d74"
    end
  end

  def install
    bin.install "mcp-devices"
    # Keep the old command available.
    bin.install_symlink bin/"mcp-devices" => "claude-in-mobile"
  end

  test do
    system "#{bin}/mcp-devices", "--version"
  end
end
