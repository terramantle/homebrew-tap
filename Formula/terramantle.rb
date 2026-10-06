class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.6.0/cli-aarch64-apple-darwin.tar.xz"
      sha256 "c9319e39bf496c3827419de2364362a3ef7a23e5a59d2b51d423d76460772f2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.6.0/cli-x86_64-apple-darwin.tar.xz"
      sha256 "7566c8386fae3a8ee270758b37800db446e85e7b203f963acfa4919db890b294"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.6.0/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81b6a92c35ba908c47ad08bb102070b095cc4e83c2f8aa4b22374d7e366e66fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.6.0/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bf6e4c8022985023140042f77a215f2f8be342ee23540c7d0d682665e1d95700"
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
