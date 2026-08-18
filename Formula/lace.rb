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
  version "2.27.0"
  # Not an SPDX-expressible license: apps/cli/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.27.0"
      sha256 "8d82b1df183915ba4712a4df0dbe52711a00b93d8a5713729bb18ce7722d687a"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.27.0"
      sha256 "aeeae108e685bf677529c91157b7b2f405b29ffcabea1af652d33e1de592caa3"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.27.0"
      sha256 "713bfe8d79702950fdccd2f845d3f697d2980b5081816956f7a7157ef85416f0"
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
