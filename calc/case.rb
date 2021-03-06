# frozen_string_literal: true

class Case
  def initialize(deck, pattern)
    @deck = deck
    @pattern = pattern
    @result = {}
  end

  attr_reader :result

  def resolve_pattern(mode)
    @cursol = 0
    @damage_sum = 0
    @cancel = []
    @pattern.each do |damage|
      @cancel << get_cancel(damage,mode)
    end
    @result = {
      source: @deck,
      cancel: @cancel,
      cursol: @cursol,
      damage_sum: @damage_sum
    }
  end

  private

  def get_cancel(damage,mode)
    #mode = 4
    damage = damage.select{|n|n>=mode-@damage_sum}.min || damage.max if damage.is_a?(Array)
    [*1..damage].each do |card|
      @cursol += 1
      return card if @deck.include?(@cursol)
    end
    @damage_sum += damage
    nil
  end
end
