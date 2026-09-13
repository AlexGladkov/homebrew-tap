class McpDevices < Formula
  desc "Fast native CLI for mobile device automation (Android/iOS/Aurora/Desktop)"
  homepage "https://github.com/AlexGladkov/claude-in-mobile"
  version "4.4.1"
  license "MIT"

  # Renamed from claude-in-mobile in 4.0 — `brew upgrade claude-in-mobile`
  # migrates existing installs to this formula.

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-arm64.tar.gz"
      sha256 "cd8e6a8bd81fd958c2808c4727558ebdf0af22bff9a322cc322f5e4a5345b341"
    end
    on_intel do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-x86_64.tar.gz"
      sha256 "2d5fc9b3cb2f06cfaf42db2545a1cc0f903eea5cdc4077b14758de183d57daf5"
    end
  end

  def install
    bin.install "mcp-devices"
    bin.install_symlink bin/"mcp-devices" => "mcp-devices-cli"
    # Keep the old command available.
    bin.install_symlink bin/"mcp-devices" => "claude-in-mobile"
  end

  test do
    system "#{bin}/mcp-devices", "--version"
    system "#{bin}/mcp-devices-cli", "--version"
  end
end
