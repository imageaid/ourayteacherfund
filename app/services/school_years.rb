# frozen_string_literal: true

class SchoolYears
  attr_reader :year, :month, :start_year, :end_year

  def initialize
    @year = Time.zone.now.year
    @month = Time.zone.now.month
    @start_year = (month < 9) ? year - 1 : year
    @end_year = (month < 9) ? year : year + 1
  end

  def current_school_year
    "#{start_year}-#{end_year}"
  end

  def future_school_years
    years = []
    beginning = start_year
    ending = end_year
    3.times do |i|
      beginning += i
      ending += i
      years << "#{beginning}-#{ending}"
    end
    years
  end

  def previous_school_years
    years = []
    beginning = start_year
    ending = end_year
    3.times do |i|
      beginning -= i
      ending -= i
      years << "#{beginning}-#{ending}"
    end
    years
  end
end
