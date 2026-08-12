# Lace Homebrew tap

Official Homebrew tap for the [Lace](https://lace.cloud) CLI.

> **No formula has been published here yet.** `Formula/` holds only a
> placeholder, so `brew install lace` currently fails with *"No available
> formula with the name 'lace'"*. `Formula/lace.rb` appears with the first CLI
> release cut through the tap pipeline. Everything below describes the tap as
> it will behave from that release onward.

```sh
brew tap lace-cloud/tap
brew install lace
lace version
```

Upgrading is `brew upgrade lace`.

## What this repository contains

Packaging metadata and one public key. `Formula/lace.rb` names the release
version and, for each supported platform, the artifact URL on
`releases.lace.cloud` and its SHA-256 digest. `release-signing.pub` is the
minisign public key those artifacts are signed with. No Lace source code and no
binaries live here. Homebrew downloads the binary from `releases.lace.cloud`
directly at install time.

Homebrew-supported platforms are macOS arm64, Linux amd64, and Linux arm64.
Intel Macs are not supported — no `darwin-amd64` artifact is built. The release
pipeline additionally builds a Windows amd64 binary, which Homebrew does not
use.

## How the formula gets here

`Formula/lace.rb` is rendered by the Lace release pipeline from a template in
the monorepo and pushed to this repository on each `cli-v*` release. **Do not
hand-edit it** — the next release overwrites it, and a hand-written digest that
disagrees with the published artifact makes `brew install` fail the checksum
check for everyone.

## Verifying a release yourself

Homebrew already verifies the SHA-256 digest pinned in the formula on every
install, and each versioned artifact is published alongside a sibling `.sha256`
you can check by hand.

Authenticity is a separate question, answered by
[minisign](https://jedisct1.github.io/minisign/) signatures. **No published
artifact carries a `.minisig` today** — every signature sidecar on
`releases.lace.cloud` currently returns 404, so there is nothing yet to verify
and no version floor to quote. Signing begins with the first release cut after
the signing pipeline lands.

From that release onward, each artifact is published with a sibling `.minisig`,
and you can check it against the key in this repository:

```sh
V=vX.Y.Z          # the version you installed — `brew info lace` shows it
A=lace-cli-darwin-arm64
curl -fsSL -O "https://releases.lace.cloud/${A}-${V}"
curl -fsSL -O "https://releases.lace.cloud/${A}-${V}.minisig"
curl -fsSL -O "https://raw.githubusercontent.com/lace-cloud/homebrew-tap/main/release-signing.pub"
minisign -Vm "${A}-${V}" -p release-signing.pub
```

Substitute `linux-amd64` or `linux-arm64` for `darwin-arm64` as needed; those
three are the only Homebrew targets.

### About the key in this repository

`release-signing.pub` here is a **mirror**. The single source of truth is
`scripts/release-signing.pub` in the Lace monorepo, and this copy is kept
byte-identical to it **by hand** — no CI job refreshes it. The release
pipeline's push to this repository copies `Formula/lace.rb` and nothing else,
and it runs only on a `cli-v*` release tag, which a key rotation does not
produce.

What the copy is worth is that it is not served from
`releases.lace.cloud`. The binaries and their signatures both come from that
bucket; a trust anchor served from the same place would prove nothing, because
whoever could rewrite the bucket could swap the key and the artifacts in one
move and every signature would still check out. Fetching the key from GitHub
instead means the bucket alone is not enough.

It is not a second, independent attestation of the key. It is one hand-made
copy of one upstream file, so comparing it against another copy of that same
file tells you whether someone forgot to update a mirror — not whether the key
is genuine. Treating a mismatch as evidence of compromise would be wrong: the
overwhelmingly likely cause is a key rotation partway through reaching every
copy. If you see one, the correct response is to ask, not to assume an attack.

A rotation must update this file by hand. Leaving it stale makes a genuine
signature fail to verify, which looks exactly like an attack to anyone
following the steps above.

## Licensing

The Lace CLI is proprietary software of Lace Cloud Inc.; installing it through
this tap does not grant rights beyond the terms shipped in the binary's
`LICENSE.txt`. This repository holds only the packaging metadata and public key
described above.

## Issues

Report problems with the CLI itself, or with this tap, through your usual Lace
support channel.
