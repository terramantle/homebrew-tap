# Terramantle Homebrew Tap

Homebrew tap for the [Terramantle CLI](https://github.com/terramantle/terramantle) — registry discovery, lock-file uploading, and state operations for Terraform/OpenTofu workflows.

## Install

```sh
brew install terramantle/tap/terramantle
```

Or tap first, then install:

```sh
brew tap terramantle/tap
brew install terramantle
```

Upgrade:

```sh
brew upgrade terramantle
```

## How this tap is maintained

Formulae in [`Formula/`](./Formula) are **published automatically** by [`cargo-dist`](https://opensource.axo.dev/cargo-dist/) on each tagged release of the CLI. Do not hand-edit them — they will be overwritten on the next release.

## Links

- CLI source & docs: https://github.com/terramantle/terramantle
- Issues: file against the [CLI repo](https://github.com/terramantle/terramantle/issues)
