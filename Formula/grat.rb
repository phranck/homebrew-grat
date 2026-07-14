class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "e86afdb41ac80391ad3f3937f37955ffc755f70626de5721b409b59889115f7e"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.1.3"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "16a3099ba2688e276213c8d01254b7fadb3641b1c5bf2445d02e045889f384d9",
           arm64_linux:  "de72ea2ece4ed0a2171ed28e28223c42a74ef93ca0759def774d4ecc6d0221a8",
           tahoe:        "620e216301da750a3c8ff9d8bf25effa48256a0d3cf1e812536911072f73e2f0",
           x86_64_linux: "3b419b6765245155151e3e5f2ec3becf171db20beba0647616a1a1f7cba90a26"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
