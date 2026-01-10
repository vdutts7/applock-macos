class Applock < Formula
  desc "Protect any macOS app behind Touch ID"
  homepage "https://github.com/vdutts7/applock-macos"
  url "https://github.com/vdutts7/applock-macos/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["12.0", :build]

  def install
    system "swiftc", "-O", "-o", "applock", "Sources/applock.swift"
    bin.install "applock"
  end

  test do
    assert_match "applock", shell_output("#{bin}/applock --version")
  end
end
