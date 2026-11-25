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
  version "2.67.1"
  # Not an SPDX-expressible license: apps/cli/internal/kernel/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.67.1"
      sha256 "900cf970a78939012ec7b1e6cc270f45d02669cc75c8eac1be9e575977832ae5"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.67.1"
      sha256 "ecfb2773b08752c3431add21e7277317b38fb954e7437ec1edb6fad806dd198b"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.67.1"
      sha256 "5f653454a67594293c5b83af2a88c55090a1638c7a0f646a0313baffdbe4c3f3"
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
