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
  version "2.53.0"
  # Not an SPDX-expressible license: apps/cli/internal/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.53.0"
      sha256 "fea4976c6be4d628f6f365eb21c50d9ccae0c6c2fb46bab5e13edb1f0185f426"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.53.0"
      sha256 "4c11adcc3703b130a3a7f8160eab35a0f0b0a230bee75c991a41cfe8fab7473d"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.53.0"
      sha256 "c711180d3ca61c0a19ba65852ef420e494cbff0e7475988239d340d6163e57bb"
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
