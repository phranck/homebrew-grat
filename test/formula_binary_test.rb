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
expected_source_url = "https://github.com/phranck/grat/archive/refs/tags/v1.3.1.tar.gz"
expected_source_checksum = "7c1d415cda93c8de4ae67b3145a2870525dc0b9dfd1600d01f0c1f67e987c066"
expected_bottle_root = "https://github.com/phranck/grat/releases/download/v1.3.1"
expected_bottle_checksums = {
  arm64_tahoe:  "ec289c1ce28e0f79575d253423d3db134748408e16e7c3a9803ddfadf7289b23",
  arm64_linux:  "c48a0072cb1d82e18c79d814fce8e45182556a7962d4dbb5bb18b1a40022ddf4",
  tahoe:        "ce218e73a709734dc8f821b6d40694fbd092b1b6f02d7d35f950b334c0d8bae8",
  x86_64_linux: "5725914aa2bd0a462aee4a275c152021b0b2fd3eb03495d4fe8e681dfaacea7f",
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
