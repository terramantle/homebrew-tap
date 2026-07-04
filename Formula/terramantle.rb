class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.1/cli-aarch64-apple-darwin.tar.xz"
      sha256 "703057c1df1106d5a06c9e01de37ceda2de923e3dba71950344d26d64ae340bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.1/cli-x86_64-apple-darwin.tar.xz"
      sha256 "4937f3b5f707c78ad1f4e03fa4ebbf00e0782de3251fdf563dc203b267139d00"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.1/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2d27367e4e7d83c4bfc140ba88cd2b8fd77c33bac334f78e0933c931bd09808"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.1/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "afb5bd598145c9523ba21e97a184dbc037faef98d372b6883232e2b0a558b0f3"
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
    bin.install "terramantle" if OS.mac? && Hardware::CPU.arm?
    bin.install "terramantle" if OS.mac? && Hardware::CPU.intel?
    bin.install "terramantle" if OS.linux? && Hardware::CPU.arm?
    bin.install "terramantle" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
