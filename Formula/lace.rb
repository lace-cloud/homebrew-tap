# Homebrew formula for the lace CLI.
#
# Rendered by tools/release/render-package-manifests.sh and pushed to
# lace-cloud/homebrew-tap as Formula/lace.rb on every cli-v* tag, which
# is where `brew tap lace-cloud/tap && brew install lace` reads it from.
# Homebrew resolves formulae through the tap, so there is no copy on
# releases.lace.cloud — only the Scoop manifest is served from there.
#
# The formula pins VERSIONED artifact URLs and their sha256 digests —
# Homebrew's own download cache is keyed on the URL, so an unversioned
# key would serve a stale binary from cache after the next release and
# fail the checksum in a way that looks like corruption.
class Lace < Formula
  desc "Infrastructure authoring, plan/apply runs, and registry access for Lace"
  homepage "https://lace.cloud"
  version "2.65.1"
  # Not an SPDX-expressible license: apps/cli/internal/kernel/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.65.1"
      sha256 "5e2ab7d2dc076ecebf5c606d8aa59730e5a3fbdd9f74e180cbd4379ab5a12ab1"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.65.1"
      sha256 "9bba3bda865ea4eb47661cfb3dcea66a1cf9c6a9198ebfa6986c925d14cc682d"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.65.1"
      sha256 "8b007cfe90c099c9e7e38efba66d7391185e05f063965e1a159e32668cc892fe"
    end
  end

  def install
    # The download is a bare binary, not an archive, so Homebrew stages
    # exactly one file named after the versioned key it was fetched by.
    bin.install Dir["lace-cli-*"].first => "lace"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lace version")
  end
end
