class McpDevices < Formula
  desc "Fast native CLI for mobile device automation (Android/iOS/Aurora/Desktop)"
  homepage "https://github.com/AlexGladkov/claude-in-mobile"
  version "4.2.0"
  license "MIT"

  # Renamed from claude-in-mobile in 4.0 — `brew upgrade claude-in-mobile`
  # migrates existing installs to this formula.
  oldname "claude-in-mobile"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-arm64.tar.gz"
      sha256 "6c892f5bf5d834d701c0ed3387c9e5528d99ee5cb553d27b74344fb5a3c56e34"
    end
    on_intel do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-x86_64.tar.gz"
      sha256 "80ea2784a2e3ca81daddc50df80263ae2a2ec0868b5f47965f6aca0eb7c1cd77"
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
