json.extract! donor, :id, :first_name, :last_name, :email, :street_address, :city, :state, :postal, :website, :credit, :created_at, :updated_at
json.url donor_url(donor, format: :json)
