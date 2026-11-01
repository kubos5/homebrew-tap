class Spotr < Formula
  desc "Spotr: A better Spotify client, for the terminal"
  homepage "https://github.com/kubos5/spotr"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.3/spotr-aarch64-apple-darwin.tar.xz"
      sha256 "6e2390a17727ad5afc496848fa0442e956cbcdc90d2b220aabe7f4c3c61f7721"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.3/spotr-x86_64-apple-darwin.tar.xz"
      sha256 "a20739bf85584abae1e35d1d232839bc5fda9518f15ab154160c54662d3fcba2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.3/spotr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a2f35f6cfaf95804c2bd2a3b5f04af010165204d79887799416303b8af8989d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kubos5/spotr/releases/download/v0.1.3/spotr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2eb193902f7bd79f6ea7be4a25ba4e45a5853fc1ad29914d6ffe39c01ad4da8f"
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
