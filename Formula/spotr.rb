class Spotr < Formula
  desc "Keyboard-first Spotify client for the terminal"
  homepage "https://github.com/kubos5/spotr"
  url "https://github.com/kubos5/spotr/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "76157cb370e2e7f2199bed262aa110c2d8dc02669a39d04b804c8bb624c57feb"
  license "GPL-3.0-or-later"
  head "https://github.com/kubos5/spotr.git", branch: "main"

  depends_on "rust" => :build
  depends_on "pkgconf" => :build
  depends_on "alsa-lib" if OS.linux?

  def install
    system "cargo", "install", *std_cargo_args   # includes --locked
  end

  def caveats
    <<~EOS
      Spotr needs Spotify Premium and your own Spotify Developer app.
      Run `spotr --setup` to get started, or `spotr --demo` to try it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/spotr --version")
  end
end
