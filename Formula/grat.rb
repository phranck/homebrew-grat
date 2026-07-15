class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.1.7.tar.gz"
  sha256 "fa775e55471e79b4191af6bfe17698f83455de71485f5c76965dc36871726073"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.1.7"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "47a3f08733cc0c1199db291657de85e5674e1c4cc394a1dc360dc2238b15913b",
           arm64_linux:  "e36a6283471d7f09b58f22bd296e8d19181e41f78f587a4b3c7eb7c027aa028f",
           tahoe:        "d9a3e634489d2ad17cae3353f244810707fc5a0e1b7e5891a319940925ce03d7",
           x86_64_linux: "19daf87f09b087a6c35051d567e2bd073296eaee69553d3c850a4039948a7db5"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
