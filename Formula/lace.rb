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
  version "2.60.1"
  # Not an SPDX-expressible license: apps/cli/internal/kernel/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.60.1"
      sha256 "615e68a90fb39220a614d1ded8afe7722949de22febd2cdd687e8a57ce43be5a"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.60.1"
      sha256 "ea3c251f9efa6346c812b63dcc2a79d8c6c0d1f8a783cf565356c2f40b7b9419"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.60.1"
      sha256 "7f03b6676781af65539bde820b11ea521d6ef197bccfd67bbdf6cd958a951767"
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
