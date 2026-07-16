class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "c3559435ba63fbbf54f874bc05c5b2e13b857547e77f93119ca73756f9816c10"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.2.0"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "aa80a6ea437a3eee036ed2f678d39d64a3118423d2e6886bc14280c9dc4601ca",
           arm64_linux:  "455befa737e7618b05c86725569b8110402d4059eef55a2cf79c178fa21403a2",
           tahoe:        "7a912279d7f04afd482d8d47045b4b9a475ce5eb3d85711acbd133d0da23fcd4",
           x86_64_linux: "aac6e6cc17df373ba99949d629d937537f72cf2a5debb11351809fcfd650d19a"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
