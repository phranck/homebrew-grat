class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "6dab4b31ab3e90fd3d021e591da3372d09de3db31f0e09fccbe5bf0994bb5ece"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.1.2"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "317e8dd96748496c633f0da8e57a1f9737c9d89027e8d587ff82ea82ae4ca3d2",
           arm64_linux:  "0fecd415cdadf04801f79c47d14d349159f20779aaa579ff6d01290586e90289",
           tahoe:        "53539b15adb4626ffb8046a0892aaefe9f1069e1bbb6727c56755d2f7304229d",
           x86_64_linux: "9fbb52b6b33aa6b73447619a19e8387c460a35eab1a89c783fa2cd56f288e32f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
