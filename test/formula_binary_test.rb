# typed: strict
# frozen_string_literal: true

# The class below stubs the parts of the Formula DSL that Formula/grat.rb calls, so
# the formula can be loaded and asserted without Homebrew. RuboCop reads those stubs
# as redefinitions of the real Formula methods, which is exactly what they are meant
# to be here.
# rubocop:disable Lint/DuplicateMethods
class Formula
  class << self
    attr_reader :urls, :checksums, :dependencies, :heads, :bottle_root_url,
                :bottle_checksums

    def desc(*)
      nil
    end

    def homepage(*)
      nil
    end

    def license(*)
      nil
    end

    def version(*)
      nil
    end

    def head(value, **)
      (@heads ||= []) << value
    end

    def test(*)
      nil
    end

    def url(value)
      (@urls ||= []) << value
    end

    def sha256(value = nil, **keywords)
      if keywords.empty?
        (@checksums ||= []) << value
      else
        (@bottle_checksums ||= []) << keywords
      end
    end

    def depends_on(value)
      (@dependencies ||= []) << value
    end

    def bottle(&block)
      class_eval(&block)
    end

    def root_url(value)
      @bottle_root_url = value
    end

    def on_macos(&block)
      class_eval(&block)
    end

    def on_linux(&block)
      class_eval(&block)
    end

    def on_arm(&block)
      class_eval(&block)
    end

    def on_intel(&block)
      class_eval(&block)
    end
  end

  # Assertions used by the checks below this class.
  module BinaryTest
    module_function

    def assert_equal(expected, actual, message)
      return if expected == actual

      raise "#{message}: expected #{expected.inspect}, got #{actual.inspect}"
    end
  end
end
# rubocop:enable Lint/DuplicateMethods

load File.expand_path("../Formula/grat.rb", __dir__)

expected_bottle_tags = [:arm64_tahoe, :arm64_linux, :tahoe, :x86_64_linux]
expected_source_url = "https://github.com/phranck/grat/archive/refs/tags/v1.4.0.tar.gz"
expected_source_checksum = "6f5a20c226dec0edbf88644886d06d49333b858dafef2cc5571c892b74350087"
expected_bottle_root = "https://github.com/phranck/grat/releases/download/v1.4.0"
expected_bottle_checksums = {
  arm64_tahoe:  "88fb15998b9f0c8bfdfa8d89848598c3a650875743a799548d11395e71ef70ae",
  arm64_linux:  "5d596be72f81b2bfc68e072364a5733e7e781af129574bebbeada980324e65db",
  tahoe:        "ececb0f9616cd699b07426dc78d988c3df6ef92ccd34e47b27360005fc61b9b9",
  x86_64_linux: "88ec3faacc1141ed7d536885806a72d6bf04057290b5d8a5e8db5a12065b976b",
}.freeze

Formula::BinaryTest.assert_equal [{ "go" => :build }], Grat.dependencies,
                                 "formula must declare Go only for source fallback builds"
Formula::BinaryTest.assert_equal [], Grat.heads || [], "formula must not advertise a source head"
Formula::BinaryTest.assert_equal [expected_source_url], Grat.urls,
                                 "formula must use the matching source archive"
Formula::BinaryTest.assert_equal [expected_source_checksum], Grat.checksums,
                                 "formula source checksum must match the published tag"
Formula::BinaryTest.assert_equal expected_bottle_root, Grat.bottle_root_url,
                                 "bottles must come from the matching grat release"

# The formula generates the manual page from the binary it just built, so a
# source build without these two lines installs a binary with no manual and
# nothing else says so. The stub cannot run the install block, so the source is
# read instead.
formula_source = File.read(File.expand_path("../Formula/grat.rb", __dir__))
[
  ['Utils.safe_popen_read(bin/"grat", "manual")', "formula must generate the manual from the built binary"],
  ['man1.install "grat.1"', "formula must install the manual page"],
].each do |needle, message|
  Formula::BinaryTest.assert_equal true, formula_source.include?(needle), message
end

bottle_checksums = Grat.bottle_checksums || []
Formula::BinaryTest.assert_equal 1, bottle_checksums.length,
                                 "formula must declare one portable bottle set"
bottle = bottle_checksums.first || {}
Formula::BinaryTest.assert_equal :any_skip_relocation, bottle[:cellar],
                                 "bottles must be relocatable"
Formula::BinaryTest.assert_equal expected_bottle_tags.sort, (bottle.keys - [:cellar]).sort,
                                 "formula must provide every supported bottle"
bottle_checksums_without_cellar = bottle.each_with_object({}) do |(key, value), checksums|
  checksums[key] = value if key != :cellar
end
Formula::BinaryTest.assert_equal expected_bottle_checksums,
                                 bottle_checksums_without_cellar,
                                 "formula checksums must match the published bottle archives"

puts "formula bottle declaration: PASS"
