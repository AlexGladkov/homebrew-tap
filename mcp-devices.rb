class McpDevices < Formula
  desc "Fast native CLI for mobile device automation (Android/iOS/Aurora/Desktop)"
  homepage "https://github.com/AlexGladkov/claude-in-mobile"
  version "4.2.1"
  license "MIT"

  # Renamed from claude-in-mobile in 4.0 — `brew upgrade claude-in-mobile`
  # migrates existing installs to this formula.
  oldname "claude-in-mobile"

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-arm64.tar.gz"
      sha256 "0487c742b43a85ca38e95da6d76154cb49e10ba52205367b71718bbedfc5fa0f"
    end
    on_intel do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-x86_64.tar.gz"
      sha256 "55cb24fdc3e29bf90f86d971d65c2d4ad6de1c39638b982e67abae73c7104115"
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
