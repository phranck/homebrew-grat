class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "d0d63d0276618911ef304853a894ed9e8f3699b5a7e583e0b8c468a1575ef66a"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.2.2"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "1b327f7a8e40100b9c839fcecd3256178aea3d9b3c0b041b2e54a12eda569212",
           arm64_linux:  "3a224f3b8afd5426799144854fffb8e4d8d004c2f6c595ff8d6493cb019fa92d",
           tahoe:        "223c1ed95b3e538e1736e9d6ab710eea19f58083ef7e02cc8ac30a961d1fb83f",
           x86_64_linux: "485d2c3adcb17bc9f1f717d6502caee0584003ab779a8bf831bc76ddb0a32097"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
