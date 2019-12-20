# frozen_string_literal: true

require 'json'
class Patterns
  def initialize(pattern_name)
    File.open('./json/pattern_master.json') do |j|
      master = JSON.parse(j.read, symbolize_names: true)
      @p_array = master[pattern_name]
    end
  end

  attr_reader :p_array

  def create; end
end
