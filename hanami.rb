class Hanami < Formula

  hanami_version = "0.0.0"
  sha256_src_darwin = "4f8d0bc10844c2dbb8519f0d498dbc8dcfacd86f52a2cba6901074849561a7d0"
  sha256_src_linux = "91393d8a7319cf27eba979bedcca8c92fe67064465a0088184c08a84ac8ca661"
  sha256_bash_completion = "2d449945b0f7419f7bcf1a2d415eeaabbc51164c423143a936b145093d79795d"

  desc "Resource monitoring and hook for the SAKURA Cloud"
  homepage "https://github.com/sacloud/hanami"
  head "https://github.com/sacloud/hanami.git"
  version hanami_version

  if OS.mac?
    url "https://github.com/sacloud/hanami/releases/download/v#{hanami_version}/hanami_darwin-amd64.zip"
    sha256 sha256_src_darwin
  else
    url "https://github.com/sacloud/hanami/releases/download/v#{hanami_version}/hanami_linux-amd64.zip"
    sha256 sha256_src_linux
  end

  option "without-completions", "Disable bash completions"
  resource "bash_completion" do
    url "https://releases.usacloud.jp/hanami/contrib/completion/bash/hanami"
    sha256 sha256_bash_completion
  end

  def install
    bin.install "hanami"
    if build.with? "completions"
      resource("bash_completion").stage {
        bash_completion.install "hanami"
      }
    end

  end

  test do
    assert_match "SAKURACLOUD_ACCESS_TOKEN", shell_output("hanami --help")
  end
end
