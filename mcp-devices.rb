class McpDevices < Formula
  desc "Fast native CLI for mobile device automation (Android/iOS/Aurora/Desktop)"
  homepage "https://github.com/AlexGladkov/claude-in-mobile"
  version "4.2.2"
  license "MIT"

  # Renamed from claude-in-mobile in 4.0 — `brew upgrade claude-in-mobile`
  # migrates existing installs to this formula.

  on_macos do
    on_arm do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-arm64.tar.gz"
      sha256 "94d6ba44597f2b63cda9def293a4d4d7913ff634e2ca2a72a97ec3fb5a636564"
    end
    on_intel do
      url "https://github.com/AlexGladkov/claude-in-mobile/releases/download/v#{version}/claude-in-mobile-#{version}-darwin-x86_64.tar.gz"
      sha256 "b6dd0ba9c0e831a19889be18589b188777186f0ff0b9e9b4592662eaeab02461"
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
