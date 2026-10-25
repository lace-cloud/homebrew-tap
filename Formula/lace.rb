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
  version "2.56.0"
  # Not an SPDX-expressible license: apps/cli/internal/kernel/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.56.0"
      sha256 "8aeb63c521db8dcd55cb01f3761c3837ed7d2a04c21720d333d19cd5cdc2a3b3"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.56.0"
      sha256 "e996214473bb97bc3c33ff3dd1bf78231e4c20675ce4c26fbf4f4de87d64764f"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.56.0"
      sha256 "80b72eba0272da789432d66b414a2ac8699ee2d0e4e700477cec82c4e2798cba"
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
