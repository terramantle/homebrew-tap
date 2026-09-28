class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.2.0/cli-aarch64-apple-darwin.tar.xz"
      sha256 "fbff0a2204324b7190d6b8a89a4d9b1a0a23c1525f0184f585a54ea00027663c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.2.0/cli-x86_64-apple-darwin.tar.xz"
      sha256 "b0209f73e74d85e52063ae30a4a2b2fa7c53de229fc10fe3845283615db3a2bc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.2.0/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca2b16f5450767279e4f72c10a5d0e4bafe86591563327d2ebd881f8fd0fc572"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.2.0/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68bf7346e828a89a9f2f7b2d288e3cb5688b2b83f189c688a7cc200dc389cf5a"
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
