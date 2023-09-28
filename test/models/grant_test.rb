# == Schema Information
#
# Table name: grants
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  details    :text
#  name       :string
#  questions  :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_grants_on_active  (active) UNIQUE
#  index_grants_on_name    (name) UNIQUE
#
require "test_helper"

class GrantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
