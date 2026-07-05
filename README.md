<div align="center">

# homebrew-tap

**The [Homebrew](https://brew.sh) tap for the [Terramantle](https://terramantle.dev) CLI** — `brew install` distribution for the `terramantle` command-line tool.

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](#license)
[![Status: experimental](https://img.shields.io/badge/status-experimental-orange.svg)](#-status--experimental)
[![CLI: terramantle-cli](https://img.shields.io/badge/cli-terramantle--cli-black.svg)](https://github.com/terramantle/terramantle-cli)

</div>

---

> ### 🧪 Status — experimental
>
> **This tap distributes the terramantle CLI, a helper tool built as an experiment.**
> The CLI is a convenience wrapper around Terramantle's public HTTP API — it is
> **not** a core/officially-supported product and carries **no stability or support
> guarantees**. This tap is just the delivery mechanism: its contents are
> machine-generated on each CLI release and provided **as-is**. Use it, fork it,
> break it — just don't build load-bearing production automation on it expecting
> long-term stability.

## What is this?

A [Homebrew tap](https://docs.brew.sh/Taps) — a third-party repository of formulae
that `brew` can install from. This one publishes a single formula,
[`Formula/terramantle.rb`](./Formula/terramantle.rb), so macOS and Linux users can
install the `terramantle` CLI with `brew`.

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

Uninstall:

```sh
brew uninstall terramantle
brew untap terramantle/tap
```

## How it's maintained

[`Formula/terramantle.rb`](./Formula/terramantle.rb) is **generated and pushed
automatically** by [`cargo-dist`](https://github.com/axodotdev/cargo-dist) on each
tagged release of the CLI. **Do not hand-edit it** — any manual change is
overwritten on the next release. The source, build config, and release workflow all
live in the CLI repository:
[`terramantle/terramantle-cli`](https://github.com/terramantle/terramantle-cli).

## Links

- **CLI source & docs** — [`terramantle/terramantle-cli`](https://github.com/terramantle/terramantle-cli)
- **Terramantle** — [terramantle.dev](https://terramantle.dev)
- **Issues** — file against the [CLI repo](https://github.com/terramantle/terramantle-cli/issues) (not this tap)

## License

This tap holds only machine-generated formulae; it ships no LICENSE file of its own.
The distributed `terramantle` CLI is licensed **MIT** — see the
[LICENSE in the CLI repo](https://github.com/terramantle/terramantle-cli/blob/main/LICENSE).
Provided **as-is**, without warranty of any kind — see the
[experimental status](#-status--experimental) note above.
</content>
</invoke>
