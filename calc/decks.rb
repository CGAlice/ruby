# frozen_string_literal: true

class Decks
  def initialize(case_name)
    File.open('./json/deck_master.json') do |j|
      master = JSON.parse(j.read, symbolize_names: true)
      @deck_statuses = master[case_name]
    end
    @d_hash = {}
  end

  attr_reader :d_hash

  def create
    @deck_statuses.each do |key, deck_status|
      @d_hash[key] = get_cx_position(deck_status)
    end
  end

  private

  def get_cx_position(params)
    cx_count = params[:cx]
    return [[]] if cx_count.zero?

    deck_sum = params[:deck_sum]
    ret = []
    [*1..deck_sum].each do |i|
      params = {
        cx: cx_count - 1,
        deck_sum: deck_sum - i
      }
      get_cx_position(params).each do |cx_position|
        ret << cx_position.push(deck_sum - i + 1)
      end
    end
    ret
  end
end
