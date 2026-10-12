class Spotr < Formula
  desc "Spotr: A better Spotify client, for the terminal"
  homepage "https://github.com/kubos5/spotr"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.2/spotr-aarch64-apple-darwin.tar.xz"
      sha256 "354c8256f1a362a416f1a8ccaf380ddac2d719724b51b0c887fbdd7b28513430"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.2/spotr-x86_64-apple-darwin.tar.xz"
      sha256 "3063eefcc1b1006f9551e0cf9f30d8c35ebe0c767f8d0379132e11b4a167dc17"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.2/spotr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "833ac08206d45ec6a6cbf5c9a00460ee11b843535c9f448e3a97ed84d0cd07f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.2/spotr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "633f26b3f7d0eb56ed81f102a8e8fd249705ff51fab9821b5fa426786c630618"
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
