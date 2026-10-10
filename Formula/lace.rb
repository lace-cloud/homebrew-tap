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
  version "2.43.0"
  # Not an SPDX-expressible license: apps/cli/internal/legal/LICENSE.txt is proprietary.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://releases.lace.cloud/lace-cli-darwin-arm64-v2.43.0"
      sha256 "33b23044bd1d70c9438bd1b3eac2efbc8c250092bec384a60cededfd1a0f896e"
    end
  end

  on_linux do
    on_intel do
      url "https://releases.lace.cloud/lace-cli-linux-amd64-v2.43.0"
      sha256 "c4c67d742617f9f33fe11cb2a23542343b84d5cf6b02a6c0dae947d55b9e2a9e"
    end
    on_arm do
      url "https://releases.lace.cloud/lace-cli-linux-arm64-v2.43.0"
      sha256 "c4adc2884db5e62d95326be2d10d8cf59ef146e955cea62474bb122538dd9991"
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
