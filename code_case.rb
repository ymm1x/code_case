#!/usr/bin/env ruby

require "active_support"
require "active_support/inflector"
require_relative "app/code_case"
require_relative "app/word_parser"

if ARGV.empty?
  warn "Usage: #{__FILE__} <InputString>"
  exit 1
end

CodeCase.run(ARGV[0])
