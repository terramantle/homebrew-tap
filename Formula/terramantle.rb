class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.0/cli-aarch64-apple-darwin.tar.xz"
      sha256 "83b43569db7a187ff9ef69ef47aae8dc10de418361c5a48dcf0d05706a0d0744"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.0/cli-x86_64-apple-darwin.tar.xz"
      sha256 "ceb81c3ccafdcd616b2d1a6b66ce3b6274d677e94919cc2698f1d2207f6951a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.0/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "686248ea50c7a6b40afbcc81a966bc9c5e852adfbb8d1fe0a3930dd014bad6c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.1.0/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bad303d09bd1cf62c793f311ba8ec10a172042c70ab2f52dba0fa0b60a3f5e05"
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
