class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.8.0/cli-aarch64-apple-darwin.tar.xz"
      sha256 "a0fac263a68420fd3bc0740ed60f1e2d7241a2938acfb06acfe717c950d8c904"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.8.0/cli-x86_64-apple-darwin.tar.xz"
      sha256 "c2083b9c796d3b172d7e9569310fe5d4e29d21e273f46e282a95037e54f463fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.8.0/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a30aadb14e82c25f3c9ef707fbc2ca0828778f5a67ed2dc46b43478e244ac195"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.8.0/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbe766b3dc73efd63562e1dc5e2b2086700efacde879d4bc73f72bfbf78e5247"
    end
  end
  license "MIT"

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
      bin.install "terramantle"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "terramantle"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "terramantle"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "terramantle"
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
