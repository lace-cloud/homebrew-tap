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
  version "2.32.1"
  # Not an SPDX-expressible license: apps/cli/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.32.1"
      sha256 "dc2ae79b9ca4ce998b12837ba2dbe7fb4e2ac616718ff1a94c45b04a99c8f67f"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.32.1"
      sha256 "a242d39e8e2405bce409ff3c3ba9476b1e66d101988770aa9aa3b00df7758e33"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.32.1"
      sha256 "bb3bdc09ad8d66cd959f02254c4344fdf3e2d826e93fbb410236fdb88c9e5e34"
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
