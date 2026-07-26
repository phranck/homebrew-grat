# typed: strict
# frozen_string_literal: true

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

  module BinaryTest
    module_function

    def assert_equal(expected, actual, message)
      return if expected == actual

      raise "#{message}: expected #{expected.inspect}, got #{actual.inspect}"
    end
  end
end

load File.expand_path("../Formula/grat.rb", __dir__)

expected_bottle_tags = [:arm64_tahoe, :arm64_linux, :tahoe, :x86_64_linux]
expected_source_url = "https://github.com/phranck/grat/archive/refs/tags/v1.2.1.tar.gz"
expected_source_checksum = "19e76e9eb56024622e753da26e7f2dd8cbd46e6a6e963904e305733bd77e8769"
expected_bottle_root = "https://github.com/phranck/grat/releases/download/v1.2.1"
expected_bottle_checksums = {
  arm64_tahoe:  "52c5c781ebf99310aab22234d34debf4d5f457c0d2c1b0bb52262efedf6b957a",
  arm64_linux:  "74e8cecce371fa241862e65f5435e1725fe8a941485e49e7f636b96804c0084c",
  tahoe:        "6411b846ae0f7d754a2bdb505be10576d36f7621d6c762892956ff068cb7f13a",
  x86_64_linux: "cf180eb305346b44c63d257562c7692735d821222ecb31b0a0b818ab8ae24500",
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
