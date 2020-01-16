# frozen_string_literal: true

require './create_result'
require './calc/decks'
require './calc/patterns'
require 'benchmark'

include CreateResult

def main
  patterns = Patterns.new(:test7)
  # patterns.create
  decks = Decks.new(:test7)
  decks.create
  ret = create_cases(patterns, decks,7)
  pp ret
end

result = Benchmark.realtime do
  main
end
puts "処理概要 #{result}s"
