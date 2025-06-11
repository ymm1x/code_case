#!/usr/bin/env ruby

require "active_support"
require "active_support/inflector"

if ARGV.empty?
  warn "Usage: #{__FILE__} <InputString>"
  exit 1
end

class CodeCase
  def self.run(input)
    new(input).print_all_cases
  end

  def initialize(input)
    @words = WordParser.parse(input)
  end

  def print_all_cases
    puts macro_case
    puts snake_case
    puts upper_camel_case
    puts lower_camel_case
  end

  private

    def macro_case
      @words.join("_").upcase
    end

    def snake_case
      @words.join("_")
    end

    def upper_camel_case
      @words.map(&:capitalize).join
    end

    def lower_camel_case
      @words.first + @words.drop(1).map(&:capitalize).join
    end
end

class WordParser
  def self.parse(str)
    new(str).words
  end

  def initialize(str)
    @input = str
  end

  def words
    case @input
    when /^[A-Z0-9_]+$/ # MACRO_CASE
      @input.split("_").map(&:downcase)
    when /_/ # snake_case
      @input.split("_")
    when /^[A-Z]/ # UpperCamelCase
      split_camel_case
    else # lowerCamelCase
      split_camel_case
    end
  end

  private

    def split_camel_case
      @input.gsub(/([a-z0-9])([A-Z])/, '\1 \2').split.map(&:downcase)
    end
end

CodeCase.run(ARGV[0])
