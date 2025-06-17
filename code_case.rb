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
    @base_words = WordParser.parse(input)
  end

  def print_all_cases
    forms = {
      "Snake Case"      => method(:snake_case),
      "LowerCamel Case" => method(:lower_camel_case),
      "UpperCamel Case" => method(:upper_camel_case),
      "Macro Case"      => method(:macro_case),
    }

    [:singular, :plural].each do |form|
      forms.each_value do |method|
        puts method.call(form)
      end
    end
  end

  private

    def macro_case(form)
      transform(form).join("_").upcase
    end

    def snake_case(form)
      transform(form).join("_")
    end

    def upper_camel_case(form)
      transform(form).map(&:capitalize).join
    end

    def lower_camel_case(form)
      first, *rest = transform(form).map(&:capitalize)
      [first.downcase, *rest].join
    end

    def transform(form)
      case form
      when :singular
        singularize_last(@base_words)
      when :plural
        pluralize_last(@base_words)
      else
        raise ArgumentError, "unknown form: #{form}"
      end
    end

    def pluralize_last(words)
      *head, last = words
      head + [last.pluralize]
    end

    def singularize_last(words)
      *head, last = words
      head + [last.singularize]
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
