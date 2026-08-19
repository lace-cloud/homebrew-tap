# Homebrew formula for the lace CLI.
#
# Rendered by scripts/render-package-manifests.sh and pushed to
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
  version "2.28.0"
  # Not an SPDX-expressible license: apps/cli/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.28.0"
      sha256 "c042f07b18475c166faf742e2a810cd8a5c4a4d5b97baa6794f473d12f9adcdc"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.28.0"
      sha256 "367a3bcd0636d282133834cff2c4eb8f57e2fa21586702748b4c4938ce3ea7f4"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.28.0"
      sha256 "88300d37ae86e6517000d5955aec254edb9d4aac7b611c474ed8b463c4007904"
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
