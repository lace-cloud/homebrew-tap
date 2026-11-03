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
  version "2.58.0"
  # Not an SPDX-expressible license: apps/cli/internal/kernel/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.58.0"
      sha256 "1f3e8a0c4606457171ba544e8c8b5af8a15bab834bf79c150ddfde4df0bdec60"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.58.0"
      sha256 "0fb84ca14c68266fe401365546d3e906797b46c60c3646db4e2f88adb3a50c71"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.58.0"
      sha256 "51a5f495af64bb7a169520b8b01921bfaac062629ade7ce123061d9f374b666a"
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
