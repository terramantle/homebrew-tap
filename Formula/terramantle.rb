class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.3.0/cli-aarch64-apple-darwin.tar.xz"
      sha256 "b9d83eeffbc716249d1a6241aa69a0a8591ee3a24b20f4536df925124d9f327d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.3.0/cli-x86_64-apple-darwin.tar.xz"
      sha256 "b41f62e23b1cf9e0e49004e3f98f6be2c5d8fdc5127de9445b3c4a668e78767d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.3.0/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8bf8b9df69ba8f5ed3a59362926db645535c71b6fbd3b7ddeb397e03d2ec56f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.3.0/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "060b9882baef3ce6068bfafaef5af2de041ddb82eac9b35aaca2f640a8bc3e41"
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
