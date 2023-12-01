class DonorsController < ApplicationController
  def index
    @donors = Donor.where("(users.meta ->> 'credit' = '1' OR users.meta ->> 'credit' = 'true')")
      .order(:last_name, :first_name)
    @donors_by_level = breakdown_by_levels(@donors)
  end

  private

  def breakdown_by_levels(donors)
    levels_hash = {
      pets: [],
      honors: [],
      deans: [],
      cum_laudes: [],
      magna_cum_laudes: [],
      summa_cum_laudes: []
    }
    donors.each do |donor|
      donor_name = donor.name.titleize
      case donor.level
      when "Teacher's Pet"
        levels_hash[:pets] << donor_name
      when "Honor Society"
        levels_hash[:honors] << donor_name
      when "Dean's List"
        levels_hash[:deans] << donor_name
      when "Cum Laude"
        levels_hash[:cum_laudes] << donor_name
      when "Magna Cum Laude"
        levels_hash[:magna_cum_laudes] << donor_name
      when "Summa Cum Laude"
        levels_hash[:summa_cum_laudes] << donor_name
      else
        next
      end
    end
    levels_hash
  end
end
