# frozen_string_literal: true

require './create_result'
require './calc/decks'
require './calc/patterns'
require 'benchmark'

include CreateResult

def main
  patterns = Patterns.new(:basic3)
  # patterns.create
  decks = Decks.new(:basic3)
  decks.create
  ret = create_cases(patterns, decks)
  pp ret
end

result = Benchmark.realtime do
  main
end
puts "処理概要 #{result}s"
