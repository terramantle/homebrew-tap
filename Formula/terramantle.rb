class Terramantle < Formula
  desc "Terramantle CLI — discover the registry, push provider lock files, operate state."
  homepage "https://terramantle.dev"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.11.0/cli-aarch64-apple-darwin.tar.xz"
      sha256 "91ac706c84fef5c90476c5fb9119f4ae5cbbe3c209475d485dfa6cbd2411a3cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.11.0/cli-x86_64-apple-darwin.tar.xz"
      sha256 "e5639f3008f3d8f1373aa0f9124de0ba2835aadb1c61228cefedc25eee1c75f6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.11.0/cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ec9ded0a2b762b75aae2d8852c1f7ab017eddc9412223d9bd76a05e9eef0354"
    end
    if Hardware::CPU.intel?
      url "https://github.com/terramantle/terramantle-cli/releases/download/v0.11.0/cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44a8278c8102eef5fffd3e768363defd9395456e76b535bef0c813e812002c5d"
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
