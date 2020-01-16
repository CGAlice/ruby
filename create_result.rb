# frozen_string_literal: true

require './calc/case'
require 'parallel'

module CreateResult
  def create_cases(patterns, deck_master,mode=0)
    Parallel.map(deck_master.d_hash, in_processes: 10) do |key, decks|
      p_cases = Parallel.map(patterns.p_array, in_processes: 10) do |pattern|
        cases = Parallel.map(decks, in_processes: 10) do |deck|
          sample_case = Case.new(deck, pattern)
          sample_case.resolve_pattern(mode)
          sample_case.result
        end
        create_case_result(pattern, cases)
      end
      {
        key => create_pattern_result(p_cases, decks.length)
      }
    end
  end

  private

  def create_case_result(pattern, cases)
    damage_sum = cases.inject(0) { |sum, hash| sum + hash[:damage_sum] }
    {
      #detail: cases,
      pattern: pattern,
      damage_sum: damage_sum,
      average: damage_sum / cases.length.to_f,
      shot: create_shot(cases)
    }
  end

  def create_pattern_result(pattern_cases, case_count)
    source = pattern_cases.group_by { |v| v[:damage_sum] }.max
    {
      detail: pattern_cases,
      count: case_count,
      max_case: create_max_patterns(source,case_count),
      max_shots: create_max_shot(pattern_cases, case_count)
    }
  end

  def create_max_patterns(source,case_count)
    ret = {
      patterns: [],
      value: source[0] / case_count.to_f
    }
    source[1].each { |v| ret[:patterns].push(v[:pattern]) }
    ret
  end

  def create_max_shot(pattern_cases, case_count)
    target = [*2..7]
    ret = {}
    target.each do |i|
      source = pattern_cases.group_by { |v| v[:shot][i] || 0 }.max
      ret[i] = create_max_patterns(source, case_count) unless source[0].zero?
    end
    ret
  end

  def create_shot(cases)
    ret = {}
    i = 0
    while i
      ret[i] = cases.count { |item| item[:damage_sum] >= i }
      i = ret[i].zero? ? false : i + 1
    end
    ret
  end
end
