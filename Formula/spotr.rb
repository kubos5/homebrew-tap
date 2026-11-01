class Spotr < Formula
  desc "Spotr: A better Spotify client, for the terminal"
  homepage "https://github.com/kubos5/spotr"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.4/spotr-aarch64-apple-darwin.tar.xz"
      sha256 "fd345d0336c511628f8c0b342e1d9a344d5342ac8813bfe14a490566bca4da25"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.4/spotr-x86_64-apple-darwin.tar.xz"
      sha256 "516e401f893c0d796203d0484f4135d729a940be54f80cb11b9b986ee048f724"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.4/spotr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4c1c6b64e0d90b1eedf770a3862fac21277bb72b94f9c39926451776d1c250c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.4/spotr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "339c432a56248e471566e91e701cef8a999b133c2a08399520b0c2e33c357ecd"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "spotr"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "spotr"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "spotr"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "spotr"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
