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
expected_source_url = "https://github.com/phranck/grat/archive/refs/tags/v1.2.3.tar.gz"
expected_source_checksum = "2f24e945ea2ede1eea20d7080e7ed3efad3bd69bfd7e843f758294cab1acfe07"
expected_bottle_root = "https://github.com/phranck/grat/releases/download/v1.2.3"
expected_bottle_checksums = {
  arm64_tahoe:  "891bd10ed4199ab5cd265f9a326bc1333f197a8047007b6dde251ee66ce0d820",
  arm64_linux:  "22bab50eac939850f9c9dce4b3c9834b2f0bbb3fd9498a1f65f83dd9869739a5",
  tahoe:        "5de2e6dd3a54fc7dd7c08acaec0f78ffb2c89e14f110aa7416a839d54c09e50a",
  x86_64_linux: "5745389dffc77380634d475a80b14fd7e6d629eb0c4db9317e06f08c34a8d548",
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
